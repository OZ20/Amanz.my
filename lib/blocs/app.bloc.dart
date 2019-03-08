import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:flutter/material.dart';

class AppPageBloc extends BlocBase {
  static final AppPageBloc _bloc = new AppPageBloc._internal();

  final GlobalKey<ScaffoldState> appScaffoldKey = new GlobalKey();

  factory AppPageBloc() {
    return _bloc;
  }

  AppPageBloc._internal() {
    this._init();
  }

  void _init() async {}

  @override
  void dispose() {}
}

AppPageBloc appBloc = new AppPageBloc();
