
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {

  final PublishSubject _post = new PublishSubject();
  Sink post = _post.sink

  @override
  void dispose() {

  }
}