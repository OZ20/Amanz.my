import 'package:amanzmy/blocs/app.bloc.dart';
import 'package:amanzmy/blocs/berita.bloc.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/blocs/category.bloc.dart';
import 'package:amanzmy/pages/primary/berita.dart';
import 'package:amanzmy/pages/primary/category.dart';
import 'package:amanzmy/pages/secondary/settings.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppPage extends StatefulWidget {
  @override
  State createState() {
    return _AppPage();
  }
}

class _AppPage extends State<AppPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      key: appBloc.appScaffoldKey,
      drawer: Theme(
        data: theme.copyWith(
          canvasColor: theme.brightness == Brightness.light
              ? Colors.white.withOpacity(0.8)
              : Colors.black.withOpacity(0.8),
        ),
        child: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                heightFactor: 5.5,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage())),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.settings),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text('Settingan'),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.moon),
                          onPressed: () => DynamicTheme.of(context)
                              .setBrightness(Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Brightness.light
                                  : Brightness.dark),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            BlocProvider<BeritaPageBloc>(
              child: BeritaPage(),
              bloc: BeritaPageBloc(),
            ),
            BlocProvider<CategoryPageBloc>(
                child: CategoryPage(), bloc: CategoryPageBloc()),
          ]),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() {
                _currentIndex = index;
                if (index == 2) {
                  appBloc.appScaffoldKey.currentState.hideCurrentSnackBar();
                  appBloc.appScaffoldKey.currentState
                      .showSnackBar(SnackBar(content: Text('Akan datang')));
                } else {
                  _tabController.animateTo(_currentIndex);
                }
              }),
          fixedColor: theme.brightness == Brightness.light
              ? Colors.blue[400]
              : Colors.white,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              title: Text(''),
              icon: Icon(FontAwesomeIcons.fortAwesomeAlt),
            ),
            BottomNavigationBarItem(
              title: Text(''),
              icon: Icon(FontAwesomeIcons.bars),
            ),
            BottomNavigationBarItem(
              title: Text(''),
              icon: Icon(FontAwesomeIcons.bell),
            ),
          ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
