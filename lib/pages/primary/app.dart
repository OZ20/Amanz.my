import 'package:amanzmy/blocs/app.bloc.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/blocs/berita.bloc.dart';
import 'package:amanzmy/blocs/promo.bloc.dart';
import 'package:amanzmy/blocs/tips.bloc.dart';
import 'package:amanzmy/blocs/tv.bloc.dart';
import 'package:amanzmy/blocs/ulasan.bloc.dart';
import 'package:amanzmy/pages/primary/berita.dart';
import 'package:amanzmy/pages/primary/promo.dart';
import 'package:amanzmy/pages/primary/tips.dart';
import 'package:amanzmy/pages/primary/tv.dart';
import 'package:amanzmy/pages/primary/ulasan.dart';
import 'package:amanzmy/pages/secondary/settings.dart';
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

class _AppPage extends State<AppPage> with TickerProviderStateMixin , AutomaticKeepAliveClientMixin {
  TabController _tabController;

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
//            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
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
                        title: MenuItem(
                            'BERITA', FontAwesomeIcons.solidNewspaper)),
                    ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _tabController.animateTo(1);
                          });
                        },
                        title: MenuItem('ULASAN', FontAwesomeIcons.book)),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                heightFactor: 5.5,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage())),
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
          controller: _tabController, children: [
        BlocProvider<BeritaPageBloc>(
          child: BeritaPage(),
          bloc: BeritaPageBloc(),
        ),
        BlocProvider<UlasanPageBloc>(
            child: UlasanPage(), bloc: UlasanPageBloc()),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
