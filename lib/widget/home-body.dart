import 'package:amanzmy/blocs/app.bloc.dart';
import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/util/sort.dart';
import 'package:amanzmy/widget/post-card.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeBody extends StatelessWidget {
  final TabController _tabController;
  final _bloc;
  HomeBody(this._tabController, this._bloc);

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final font = theme.textTheme;
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                forceElevated: innerBoxIsScrolled,
                centerTitle: true,
                leading: _bloc.title == 'BERITA'
                    ? InkWell(
                        onTap: () =>
                            appBloc.appScaffoldKey.currentState.openDrawer(),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Image.asset(
                                  'assets/img/amanz-logo-single.jpg'),
                            )),
                      )
                    : IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context)),
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
        ));
  }

  Widget pageBody(SortBy sort) {
    print(_bloc.toString() + sort.toString());
    switch (sort) {
      case SortBy.popular:
        final ScrollController _scrollController = new ScrollController();
        return mainWidget(_bloc.postPopular, sort, _scrollController);
      default:
        final ScrollController _scrollController = new ScrollController();
        return mainWidget(_bloc.postNew, sort, _scrollController);
    }
  }

  Widget mainWidget(bloc, sort, controller) {
    return StreamBuilder(
        stream: bloc,
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState != ConnectionState.done) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notify) =>
                  _handleScrollNotification(notify, sort),
              child: RefreshIndicator(
                displacement: 10,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.blue
                    : Colors.white,
                onRefresh: () => _bloc.init(),
                child: ListView.builder(
                    key: PageStorageKey(sort),
                    controller: controller,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Center(child: PostCard(snapshot.data[index], controller));
                    }),
              ),
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
              (notification.metrics.maxScrollExtent * 0.2))) {
        if (!_bloc.loadMore) _bloc.getMorePost(sort);
      }
    }
    return false;
  }
}
