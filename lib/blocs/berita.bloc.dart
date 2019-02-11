import 'dart:async';

import 'package:amanzmy/apis/post.api.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/util/sort.dart';
import 'package:rxdart/rxdart.dart';

class BeritaPageBloc extends BlocBase {

  BeritaPageBloc();

  void init(){
    print('widget init');
    getPost().then((data) => filterData(data, sort: SortBy.popular)).catchError((e) => print(e));
    getPost().then((data) => filterData(data, sort: SortBy.newPost)).catchError((e) => print(e));
  }


  final Subject<List<Post>> _postNew = new BehaviorSubject();

  Sink<List<Post>> get sinkPostNew => _postNew.sink;

  Stream<List<Post>> get postNew => _postNew.stream;

  final Subject<List<Post>> _postPopular = new BehaviorSubject();

  Sink<List<Post>> get sinkPostPopular => _postPopular.sink;

  Stream<List<Post>> get postPopular => _postPopular.stream;

  static final List<Post> _popularPosts = [];
  static final List<Post> _newPosts = [];

  void filterData(List data, {SortBy sort}) {
    print('filter berita called');
    if(_postNew.isClosed)
      return;
    switch (sort){
      case SortBy.newPost:
        data.forEach((post) => _newPosts.add(Post.fromJson(post)));
        sinkPostNew.add(_newPosts);
        break;
      case SortBy.popular:
        data.forEach((post) => _popularPosts.add(Post.fromJson(post)));
        sinkPostPopular.add(_popularPosts);
        break;
      default:
        data.forEach((post) => _newPosts.add(Post.fromJson(post)));
        sinkPostNew.add(_newPosts);
        break;
    }
  }

  void getMorePost(SortBy sort) async {
    switch (sort){
      case SortBy.newPost:
        await getPost(offset: _newPosts.length).then((data) => data.forEach((post) => _newPosts.add(Post.fromJson(post))));
        sinkPostNew.add(_newPosts);
        break;
      case SortBy.popular:
        await getPost(offset: _popularPosts.length).then((data) => data.forEach((post) => _popularPosts.add(Post.fromJson(post))));
        sinkPostPopular.add(_popularPosts);
        break;
      default:
        await getPost(offset: _newPosts.length).then((data) => data.forEach((post) => _newPosts.add(Post.fromJson(post))));
        sinkPostNew.add(_newPosts);
        break;
    }
  }

  @override
  void dispose() {
    _postNew?.close();
    _postPopular?.close();
    _popularPosts?.clear();
    _newPosts?.clear();
  }
}