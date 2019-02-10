import 'package:amanzmy/blocs/app.bloc.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/util/sort.dart';
import 'package:amanzmy/widget/post-card.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class Homepage extends StatefulWidget {
  @override
  State createState() {
    return _HomePage();
  }
}

class _HomePage extends State<Homepage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final font = theme.textTheme;
    final AppBloc _bloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 300.0),
                child: Column(
                  children: <Widget>[
                    Text('Category 1'),
                    Text('Category 2'),
                    Text('Category 3'),
                    Text('Category 4'),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.settings),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0),
                              child: Text('Settings'),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.moon), onPressed: () =>
                            DynamicTheme.of(context).setBrightness(Theme
                                .of(context)
                                .brightness == Brightness.dark ? Brightness
                                .light : Brightness.dark)
                          ,),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: theme.backgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerScrolled) {
            return <Widget>[
              SliverAppBar(
                centerTitle: true,
                leading: InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Image.asset('assets/img/amanz-logo-single.jpg'),
                      )),
                ),
                title: Image.asset(
                  'assets/img/amanz-logo-big.png',
                  filterQuality: FilterQuality.high,
                ),
                pinned: true,
                forceElevated: innerScrolled,
                bottom: TabBar(
                    indicatorWeight: 5.0,
                    labelColor: theme.brightness == Brightness.light ? Colors.white : Colors.black,
                    labelStyle: font.title.copyWith(fontSize: 18),
                    unselectedLabelColor: theme.brightness == Brightness.light ? Colors.blue[400] : Colors.white,
                    indicator: new BubbleTabIndicator(
                      insets: EdgeInsets.symmetric(horizontal: 30.0),
                      indicatorHeight: 55.0,
                      indicatorColor: theme.brightness == Brightness.light ? Colors.blue[400] : Colors.white,
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
            pageBody(SortBy.newPost, _bloc),
            pageBody(SortBy.popular, _bloc),
          ]),
        ));
  }

  Widget pageBody(SortBy sort, AppBloc bloc) {
    print('pagebody');
    switch (sort) {
      case SortBy.newPost:
        bloc.sinkChangePage.add(SortBy.newPost);
        return mainWidget(bloc.postNew);
      case SortBy.popular:
        bloc.sinkChangePage.add(SortBy.popular);
        return mainWidget(bloc.postPopular);
      default:
        return mainWidget(bloc.postNew);
    }
  }

  Widget mainWidget(bloc) {
    return StreamBuilder(
        stream: bloc,
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Center(child: PostCard(snapshot.data[index]));
                        })
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
