import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/blocs/ulasan.bloc.dart';
import 'package:amanzmy/widget/home-body.dart';
import 'package:flutter/material.dart';

class UlasanPage extends StatefulWidget {

  @override
  State createState() {
    return _UlasanPage();
  }

  UlasanPage();
}

class _UlasanPage extends State<UlasanPage> with TickerProviderStateMixin {
  TabController _tabController;
  var _bloc;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    _bloc = BlocProvider.of<UlasanPageBloc>(context)..init();
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
