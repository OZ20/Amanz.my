import 'package:amanzmy/util/colors.dart';
import 'package:flutter/material.dart';

ThemeData appTheme(Brightness brightness) => new ThemeData(
      /// Default [ThemeData]
      bottomAppBarTheme: BottomAppBarTheme(elevation: 5.0,shape: CircularNotchedRectangle(), color: brightness == Brightness.light ? Colors.white : Colors.black),
      brightness: brightness,
      primaryColorBrightness: brightness,
      primaryColorDark: Colors.black,
      primaryColorLight: Colors.white,
      primaryColor: brightness == Brightness.light ? Colors.white : Colors.black,
      accentColor: brightness == Brightness.light ? Colors.blue[400] : Colors.white,
      accentColorBrightness: brightness,
      iconTheme: IconThemeData(
        color: brightness == Brightness.light ? Colors.blue[400] : Colors.white
      ),

      backgroundColor:
          brightness == Brightness.light ? Colors.grey[300] : Colors.grey[900],

      /// Text Theme
      fontFamily: 'Roboto',
      textTheme: TextTheme(
        headline: TextStyle(
            fontSize: 25.0,
            fontFamily: 'BebasNues',
            fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        body1: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w200),
      ),
    );
