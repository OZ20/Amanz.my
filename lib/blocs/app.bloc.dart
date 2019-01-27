
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {

  final PublishSubject _post = new PublishSubject();

  @override
  void dispose() {

  }
}