import 'package:amanzmy/util/colors.dart';
import 'package:flutter/material.dart';

ThemeData appTheme(Brightness brightness) => new ThemeData(
      ///
      /// Default [ThemeData]
      ///
      bottomAppBarTheme: BottomAppBarTheme(
          elevation: 5.0,
          shape: CircularNotchedRectangle(),
          color: brightness == Brightness.light ? Colors.white : Colors.black),
      brightness: brightness,
      primaryColorBrightness: brightness,
      primaryColorDark: Colors.black,
      primaryColorLight: Colors.white,
      primaryColor:
          brightness == Brightness.light ? Colors.white : Colors.black,
      accentColor:
          brightness == Brightness.light ? Colors.blue[400] : Colors.white,
      accentColorBrightness: brightness,
      backgroundColor:
          brightness == Brightness.light ? Colors.grey[300] : Colors.grey[900],
      canvasColor: brightness == Brightness.light ? Colors.white : Colors.black,

      ///
      /// Icon Theme
      ///
      iconTheme: IconThemeData(
          color:
              brightness == Brightness.light ? Colors.blue[400] : Colors.white),

      ///
      /// Button Theme
      ///
      buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          textTheme: ButtonTextTheme.primary,
          buttonColor:
              brightness == Brightness.light ? Colors.blue[400] : Colors.white),

      ///
      /// Chip Theme
      ///
      chipTheme: ChipThemeData(
          backgroundColor: brightness == Brightness.light ? Colors.blue[400] : Colors.grey[900],
          disabledColor:  brightness == Brightness.light ? Colors.blue[400] : Colors.grey[900],
          selectedColor:  brightness == Brightness.light ? Colors.blue[400] : Colors.grey[900],
          secondarySelectedColor:  brightness == Brightness.light ? Colors.blue[400] : Colors.grey[900],
          labelPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          padding: const EdgeInsets.all(4),
          shape: StadiumBorder(),
          labelStyle: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal),
          secondaryLabelStyle: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal),
          brightness: brightness),

      ///
      /// Page Transition
      ///
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),

      ///
      /// Text Theme
      ///
      fontFamily: 'Roboto',
      textTheme: TextTheme(
        headline: TextStyle(
            fontSize: 25.0,
            fontFamily: 'BebasNues',
            fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        display1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        body1: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w200),
      ),
    );
