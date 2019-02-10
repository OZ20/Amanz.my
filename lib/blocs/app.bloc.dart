import 'package:amanzmy/apis/post.api.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/util/sort.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {

  AppBloc() {
    getAllPost().then((data) => filterData(data));
    changePage.listen((data) {
      if (data == SortBy.newPost) {
        getAllPost().then((data) => filterData(data, sort: SortBy.newPost));
      }
      else if (data == SortBy.popular) {
        getAllPost().then((data) => filterData(data, sort: SortBy.popular));
      }
      else
        throw Error();
    });
  }

  final PublishSubject<SortBy> _changePage = new PublishSubject();

  Sink<SortBy> get sinkChangePage => _changePage.sink;

  Stream<SortBy> get changePage => _changePage.stream;

  final BehaviorSubject<List<Post>> _postNew = new BehaviorSubject();

  Sink<List<Post>> get sinkPostNew => _postNew.sink;

  Stream<List<Post>> get postNew => _postNew.stream;

  final BehaviorSubject<List<Post>> _postPopular = new BehaviorSubject();

  Sink<List<Post>> get sinkPostPopular => _postPopular.sink;

  Stream<List<Post>> get postPopular => _postPopular.stream;

  void filterData(List data, {SortBy sort}) {
    List<Post> posts = [];
    data.forEach((post) => posts.add(Post.fromJson(post)));

    switch (sort){
      case SortBy.newPost:
        sinkPostNew.add(posts);
        break;
      case SortBy.popular:
        sinkPostPopular.add(posts);
        break;
      default:
        sinkPostNew.add(posts);
        break;
    }
  }

  @override
  void dispose() {
    _postNew?.close();
    _postPopular?.close();
    _changePage?.close();
  }
}