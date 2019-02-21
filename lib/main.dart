import 'package:amanzmy/blocs/app.bloc.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/pages/primary/app.dart';
import 'package:amanzmy/util/app.theme.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
              localizationsDelegates: [
                // ... app-specific localization delegate[s] here
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en', 'US'), // English
                const Locale('my', 'MY'), // Malay
              ],
              title: 'Amanz.my',
              theme: theme,
              home: BlocProvider<AppPageBloc>(
                  child: AppPage(), bloc: AppPageBloc())),
    );
  }
}
