import 'package:amanzmy/blocs/app.bloc.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/pages/homepage.dart';
import 'package:amanzmy/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (Brightness brightness) => new ThemeData(
        // Todo split [ThemeData] to different files
        // Default ThemeData
        brightness: brightness,
        primaryColorBrightness: brightness,
        primaryColorDark: Colors.black,
        primaryColorLight: Colors.white,
        primarySwatch: kWhite,
        accentColorBrightness: brightness,
        backgroundColor: brightness == Brightness.light ? Colors.grey[300] : Colors.grey[900],
        // Text Theme
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 25.0, fontFamily: 'BebasNues'),
          title: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          body1: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w200),
        ),
      ),
      themedWidgetBuilder: (context, theme) =>
          MaterialApp(
            title: 'Amanz.my',
            theme: theme,
            home: BlocProvider<AppBloc>(
              child: Homepage(),
              bloc: AppBloc(),
            ),
          ),
    );
  }
}

