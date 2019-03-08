import 'package:amanzmy/blocs/berita.bloc.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/widget/home-body.dart';
import 'package:flutter/material.dart';

class BeritaPage extends StatefulWidget {
  @override
  State createState() {
    return _BeritaPage();
  }

  BeritaPage();
}

class _BeritaPage extends State<BeritaPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  BeritaPageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    _bloc = BlocProvider.of<BeritaPageBloc>(context)..init();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

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
