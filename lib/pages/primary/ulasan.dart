import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/blocs/ulasan.bloc.dart';
import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/util/sort.dart';
import 'package:amanzmy/widget/post-card.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UlasanPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _appScaffoldKey;

  @override
  State createState() {
    return _UlasanPage();
  }

  UlasanPage(this._appScaffoldKey);
}

class _UlasanPage extends State<UlasanPage> with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController = new ScrollController();
  UlasanPageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    _bloc = BlocProvider.of<UlasanPageBloc>(context)..init();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
    _bloc.dispose();
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
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
                  onTap: () => widget._appScaffoldKey.currentState.openDrawer(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Image.asset('assets/img/amanz-logo-single.jpg'),
                      )),
                ),
                title: Text(
                  'Ulasan',
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
        ));
  }

  Widget pageBody(SortBy sort) {
    print('pagebody');
    switch (sort) {
      case SortBy.newPost:
        return mainWidget(_bloc.postNew, sort);
      case SortBy.popular:
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
            return Center(
              child: NotificationListener<ScrollNotification>(
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
      if (_scrollController.position.extentAfter == 0) {
        _bloc.getMorePost(sort);
      }
    }
    return false;
  }
}
