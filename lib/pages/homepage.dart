import 'package:amanzmy/blocs/app.bloc.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/util/sort.dart';
import 'package:amanzmy/widget/post-card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppBloc _bloc = BlocProvider.of<AppBloc>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Icon(Icons.home),
                SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      hintText: 'Seacrh',
                    ),
                  ),
                ),
              ],
            ),
            bottom: TabBar(tabs: [Text('New'), Text('Popular')]),
          ),
          backgroundColor: Colors.grey[300],
          body: TabBarView(
              controller: DefaultTabController.of(context),
              children: [
            pageBody(SortBy.newPost,_bloc),
            pageBody(SortBy.popular,_bloc),
              ])),
    );
  }

  Widget pageBody(SortBy sort, AppBloc bloc) {
    print('pagebody');
    switch (sort) {
      case SortBy.newPost:
        bloc.sinkChangePage.add(SortBy.newPost);
        break;
      case SortBy.popular:
        bloc.sinkChangePage.add(SortBy.popular);
        break;
    }
    return StreamBuilder(
        stream: bloc.post,
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: mainWidget(snapshot.data),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget mainWidget(List<Post> data) {
    return Center(
      child: Column(
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Center(child: PostCard(data[index]));
              })
        ],
      ),
    );
  }
}
