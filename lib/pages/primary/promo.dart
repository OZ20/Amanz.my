import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/blocs/promo.bloc.dart';
import 'package:amanzmy/widget/home-body.dart';
import 'package:flutter/material.dart';

class PromoPage extends StatefulWidget {
  @override
  State createState() {
    return _PromoPage();
  }

  PromoPage();
}

class _PromoPage extends State<PromoPage> with TickerProviderStateMixin {
  TabController _tabController;
  PromoPageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    _bloc = BlocProvider.of<PromoPageBloc>(context)..init();
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
