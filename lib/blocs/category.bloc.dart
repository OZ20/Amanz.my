import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/util/search-state.dart';
import 'package:amanzmy/util/strings.dart';
import 'package:flutter/material.dart';
import 'bloc.provider.dart';
import 'package:amanzmy/apis/amanz.api.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class CategoryPageBloc extends BlocBase {
  CategoryPageBloc();

  void init() {
    _querySubject
        .distinct()
        .debounce(Duration(milliseconds: 450))
        .listen((query) => _searchPost(query));
  }

  String get title => 'category';

  PageStorageKey get scrollViewKey => PageStorageKey(title);

  ///
  /// Loading initial subject
  ///
  final Subject<SearchState> _loadingInitial = PublishSubject();

  Sink<SearchState> get loadingInitialSink => _loadingInitial.sink;

  Stream<SearchState> get loadingInitialStream => _loadingInitial.stream;

  ///
  /// Loading more subject
  ///
  final Subject<SearchState> _loadingMore = PublishSubject();

  Sink<SearchState> get loadingMoreSink => _loadingMore.sink;

  Stream<SearchState> get loadingMoreStream => _loadingMore.stream;

  ///
  /// Should load more subject
  ///
  final Subject<bool> _shouldLoadMore = PublishSubject();

  Sink<bool> get shouldLoadMoreSink => _shouldLoadMore.sink;

  Stream<bool> get shouldLoadMoreStream => _shouldLoadMore.stream;

  ///
  /// Query subject
  ///
  final Subject<String> _querySubject = PublishSubject();

  Sink<String> get querySink => _querySubject.sink;

  Stream<String> get queryStream => _querySubject.stream;

  ///
  /// List post subject
  ///
  final Subject<List<Post>> _postSubject = BehaviorSubject();

  Sink<List<Post>> get postSink => _postSubject.sink;

  Stream<List<Post>> get postStream => _postSubject.stream;

  ///
  /// List post getter and method
  ///
  static final List<Post> _postList = List();

  int get postListLength => _postList.length;

  void getMorePost(String query, int offset) async {
    await getPost(
            count: 6,
            addUri: searchUrl + query.replaceAll(' ', '+'),
            offset: offset ?? 0)
        .then((data) {
      if (data.length > 5) {
        data.removeLast();
        shouldLoadMoreSink.add(true);
      } else {
        shouldLoadMoreSink.add(false);
      }
      data.forEach((post) => _postList.add(Post.fromJson(post)));
    }).whenComplete(() {
      postSink.add(_postList);
      loadingMoreSink.add(SearchState.onSuccess);
    });
  }

  void _searchPost(String query, {int offset}) async {
    print('searching');
    if (query.isNotEmpty) {
      loadingInitialSink.add(SearchState.onLoading);
      await getPost(
              count: 6,
              addUri: searchUrl + query.replaceAll(' ', '+'),
              offset: offset ?? 0)
          .then((data) {
        _postList.clear();
        if (data.length > 5) {
          data.removeLast();
          shouldLoadMoreSink.add(true);
        } else {
          shouldLoadMoreSink.add(false);
        }
        data.forEach((post) => _postList.add(Post.fromJson(post)));
      }).whenComplete(() {
        postSink.add(_postList);
      }).whenComplete(() => loadingInitialSink.add(SearchState.onSuccess));
    }
  }

  void clear() {
    _postList.clear();
    _shouldLoadMore.add(false);
    _loadingMore.add(SearchState.onInitial);
    _loadingInitial.add(SearchState.onInitial);
  }

  @override
  void dispose() {
    // loading subject
    _loadingInitial.close();
    _loadingMore.close();
    _shouldLoadMore.close();
    // post related subject
    _querySubject.close();
    _postSubject.close();
  }
}
