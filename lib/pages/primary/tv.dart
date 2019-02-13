import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/blocs/tv.bloc.dart';
import 'package:amanzmy/widget/home-body.dart';
import 'package:flutter/material.dart';

class TvPage extends StatefulWidget {

  @override
  State createState() {
    return _TvPage();
  }

  TvPage();
}

class _TvPage extends State<TvPage> with TickerProviderStateMixin {
  TabController _tabController;
  TvPageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    _bloc = BlocProvider.of<TvPageBloc>(context)..init();
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
