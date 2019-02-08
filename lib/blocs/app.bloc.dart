
import 'package:amanzmy/apis/post.api.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/util/sort.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {

  AppBloc(){
    getAllPost().then((data) => filterData(data));
    changePage.listen((data) {
      print('changed page');
      if(data == SortBy.newPost)
        getAllPost().then((data) => filterData(data));
      else if(data == SortBy.popular)
        getAllPost().then((data) => filterData(data));
      else throw Error();
    });
  }

  final PublishSubject<SortBy> _changePage = new PublishSubject();
  Sink<SortBy> get sinkChangePage => _changePage.sink;
  Stream<SortBy> get changePage => _changePage.stream;


  final PublishSubject<List<Post>> _post = new PublishSubject();
  Sink<List<Post>> get sinkPost => _post.sink;
  Stream<List<Post>> get post => _post.stream;

  void filterData(List data){
    List<Post> posts = [];
    data.forEach((post) => posts.add(Post.fromJson(post)));
    sinkPost.add(posts);
  }

  @override
  void dispose() {
    _post?.close();
    _changePage?.close();
  }
}