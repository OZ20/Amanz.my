import 'package:amanzmy/blocs/app.bloc.dart';
import 'package:amanzmy/blocs/berita.bloc.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/blocs/category.bloc.dart';
import 'package:amanzmy/blocs/ulasan.bloc.dart';
import 'package:amanzmy/pages/primary/app.dart';
import 'package:amanzmy/pages/primary/berita.dart';
import 'package:amanzmy/pages/primary/category.dart';
import 'package:amanzmy/pages/primary/ulasan.dart';
import 'package:amanzmy/pages/secondary/settings.dart';
import 'package:amanzmy/util/app.theme.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

void main() {
  try {
    runApp(MyApp());
  } on Exception catch (e) {
    throw e;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (Brightness brightness) => appTheme(brightness),
      themedWidgetBuilder: (context, theme) => MaterialApp(
          routes: routes,
          title: 'Amanz.my',
          theme: theme,
          home:
              BlocProvider<AppPageBloc>(child: AppPage(), bloc: AppPageBloc())),
    );
  }
}

final routes = {
  'berita': (BuildContext context) =>
      BlocProvider(child: BeritaPage(), bloc: BeritaPageBloc()),
  'ulasan': (BuildContext context) =>
      BlocProvider(child: UlasanPage(), bloc: UlasanPageBloc()),
  'category': (BuildContext context) =>
      BlocProvider(child: CategoryPage(), bloc: CategoryPageBloc()),
  'setting': (BuildContext context) => SettingsPage(),
};
