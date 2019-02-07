import 'package:amanzmy/blocs/app.bloc.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppBloc _bloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      body: StreamBuilder(
          stream: _bloc.post,
          builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: mainWidget(snapshot.data),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  Widget mainWidget(data) {
    return Column(
      children: <Widget>[],
    );
  }
}
