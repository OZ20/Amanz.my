import 'package:amanzmy/blocs/app.bloc.dart';
import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/util/sort.dart';
import 'package:amanzmy/widget/post-card.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeBody extends StatelessWidget{

  final TabController _tabController;
  final _bloc;
  final ScrollController _scrollController = new ScrollController();

  HomeBody(this._tabController, this._bloc);


  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final font = theme.textTheme;
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerScrolled) {
            return <Widget>[
              SliverAppBar(
                centerTitle: true,
                leading: InkWell(
                  onTap: () => AppPageBloc.appScaffoldKey.currentState.openDrawer(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Image.asset('assets/img/amanz-logo-single.jpg'),
                      )),
                ),
                title: Text(
                  _bloc.title,
                  style: font.headline.copyWith(
                    shadows: <Shadow>[
                      Shadow(
                          color: theme.brightness == Brightness.light
                              ? Colors.blue[300]
                              : Colors.white,
                          blurRadius: 6)
                    ],
                    fontSize: 18.0,
                    color: theme.brightness == Brightness.light
                        ? Colors.blue
                        : Colors.white,
                  ),
                ),
                pinned: true,
                forceElevated: innerScrolled,
                bottom: TabBar(
                    indicatorWeight: 5.0,
                    labelColor: theme.brightness == Brightness.light
                        ? Colors.white
                        : Colors.black,
                    labelStyle: font.title.copyWith(fontSize: 16),
                    unselectedLabelColor: theme.brightness == Brightness.light
                        ? Colors.blue[400]
                        : Colors.white,
                    indicator: new BubbleTabIndicator(
                      insets: EdgeInsets.symmetric(horizontal: 30.0),
                      indicatorHeight: 55.0,
                      indicatorColor: theme.brightness == Brightness.light
                          ? Colors.blue[400]
                          : Colors.white,
                      tabBarIndicatorSize: TabBarIndicatorSize.tab,
                    ),
                    controller: _tabController,
                    tabs: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Icon(FontAwesomeIcons.clock),
                            ),
                            Text('Baru')
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Icon(FontAwesomeIcons.fireAlt),
                            ),
                            Text('Popular')
                          ])
                    ]),
              )
            ];
          },
          body: TabBarView(controller: _tabController, children: [
            pageBody(SortBy.newPost),
            pageBody(SortBy.popular),
          ]),
        )
    );
  }

  Widget pageBody(SortBy sort) {
    switch (sort) {
      case SortBy.newPost:
        print('init new berita widget');
        return mainWidget(_bloc.postNew, sort);
      case SortBy.popular:
        print('init new berita popular');
        return mainWidget(_bloc.postPopular, sort);
      default:
        return mainWidget(_bloc.postNew, sort);
    }
  }

  Widget mainWidget(bloc, sort) {
    return StreamBuilder(
        stream: bloc,
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState != ConnectionState.done) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notify) =>
                  _handleScrollNotification(notify, sort),
              child: ListView.builder(
                  key: PageStorageKey(sort),
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Center(child: PostCard(snapshot.data[index]));
                  }),
            );
          } else if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('Tiada hubungan internet!'),
            );
          }
        });
  }

  bool _handleScrollNotification(ScrollNotification notification, sort) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.pixels >=
          (notification.metrics.maxScrollExtent -
              (notification.metrics.maxScrollExtent * 0.1))) {
        if (!_bloc.loadMore)
          _bloc.getMorePost(sort);
      }
    }
    return false;
  }
}
