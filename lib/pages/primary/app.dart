import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/blocs/berita.bloc.dart';
import 'package:amanzmy/blocs/ulasan.bloc.dart';
import 'package:amanzmy/pages/primary/berita.dart';
import 'package:amanzmy/pages/primary/ulasan.dart';
import 'package:amanzmy/widget/menu-item.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppPage extends StatefulWidget {
  @override
  State createState() {
    return _AppPage();
  }
}

class _AppPage extends State<AppPage> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _appScaffold = new GlobalKey();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    print(_tabController.index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _appScaffold,
      drawer: Theme(
        data: theme.copyWith(canvasColor: theme.brightness == Brightness.light ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),),
        child: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 300.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _tabController.animateTo(0);
                          });
                        },
                        title:
                            MenuItem('Berita', FontAwesomeIcons.solidNewspaper)),
                    ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _tabController.animateTo(1);
                          });
                        },
                        title: MenuItem('Ulasan', FontAwesomeIcons.book))
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text('Settings'),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.moon),
                          onPressed: () => DynamicTheme.of(context).setBrightness(
                              Theme.of(context).brightness == Brightness.dark
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
      body: TabBarView(controller: _tabController, children: [
        BlocProvider<BeritaPageBloc>(
          child: BeritaPage(_appScaffold),
          bloc: BeritaPageBloc(),
        ),
        BlocProvider<UlasanPageBloc>(
            child: UlasanPage(_appScaffold), bloc: UlasanPageBloc()),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
