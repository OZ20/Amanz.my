import 'package:amanzmy/apis/post.api.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/util/sort.dart';
import 'package:amanzmy/util/strings.dart';
import 'package:rxdart/rxdart.dart';

class PromoPageBloc extends BlocBase {
  void init() async {
    await getPost(addUri: promoUrl)
        .then((data) => filterData(data, sort: SortBy.popular))
        .catchError((e) => print(e));
    await getPost(addUri: promoUrl)
        .then((data) => filterData(data, sort: SortBy.newPost))
        .catchError((e) => print(e));
  }

  bool _loading = false;

  bool get loadMore => _loading;

  String get title => 'PROMO';

  final Subject<List<Post>> _postNew = new BehaviorSubject();

  Sink<List<Post>> get sinkPostNew => _postNew.sink;

  Stream<List<Post>> get postNew => _postNew.stream;

  final Subject<List<Post>> _postPopular = new BehaviorSubject();

  Sink<List<Post>> get sinkPostPopular => _postPopular.sink;

  Stream<List<Post>> get postPopular => _postPopular.stream;

  static final List<Post> _popularPosts = new List();
  static final List<Post> _newPosts = new List();

  void filterData(List data, {SortBy sort}) {
    if (_postNew.isClosed) return;
    switch (sort) {
      case SortBy.newPost:
        print('new berita called');
        data.forEach((post) => _newPosts.add(Post.fromJson(post)));
        sinkPostNew.add(_newPosts);
        break;
      case SortBy.popular:
        print('popular berita called');
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
    try {
      switch (sort) {
        case SortBy.newPost:
          _loading = true;
          await getPost(addUri: promoUrl, offset: _newPosts.length)
              .then((data) =>
                  data.forEach((post) => _newPosts.add(Post.fromJson(post))))
              .whenComplete(() => _loading = false);
          sinkPostNew.add(_newPosts);
          break;
        case SortBy.popular:
          _loading = true;
          await getPost(addUri: promoUrl, offset: _popularPosts.length)
              .then((data) => data
                  .forEach((post) => _popularPosts.add(Post.fromJson(post))))
              .whenComplete(() => _loading = false);
          sinkPostPopular.add(_popularPosts);
          break;
        default:
          break;
      }
    } on Exception catch (e) {
      throw e;
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
