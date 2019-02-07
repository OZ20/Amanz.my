
import 'package:amanzmy/apis/post.api.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {

  AppBloc(){
    getAllPost().then((data) => filterData(data));
  }

  final PublishSubject _post = new PublishSubject();
  Sink get sink => _post.sink;
  Stream get post => _post.stream;

  void filterData(data){
    sink.add(data);
  }

  @override
  void dispose() {
    _post.close();
  }
}