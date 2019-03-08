import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/blocs/tips.bloc.dart';
import 'package:amanzmy/widget/home-body.dart';
import 'package:flutter/material.dart';

class TipsPage extends StatefulWidget {
  @override
  State createState() {
    return _TipsPage();
  }

  TipsPage();
}

class _TipsPage extends State<TipsPage> with TickerProviderStateMixin {
  TabController _tabController;
  TipsPageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    _bloc = BlocProvider.of<TipsPageBloc>(context)..init();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
    _bloc.dispose();
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    return HomeBody(
      _tabController,
      _bloc,
    );
  }
}
