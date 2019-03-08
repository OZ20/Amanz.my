import 'package:rxdart/rxdart.dart';

import 'bloc.provider.dart';

class ArticlePageBloc extends BlocBase {
  double _textDefaultSize = 18;

  ///
  /// Text sizing subject
  /// increment & decrement on button tap
  Subject<double> _incrementSize = PublishSubject();

  Sink<double> get incrementSizeSink => _incrementSize.sink;

  Subject<double> _decrementSize = PublishSubject();

  Sink<double> get decrementSizeSink => _decrementSize.sink;

  Subject<double> _textSizeSubject = PublishSubject();

  Sink<double> get _textSizeSink => _textSizeSubject.sink;

  Stream<double> get textSizeStream => _textSizeSubject.stream;

  ///
  /// BottomAppBar change on Web tabView
  ///
  Subject<int> _tabControllerIndex = PublishSubject();

  Sink<int> get sinkTabControllerIndex => _tabControllerIndex.sink;

  Stream<int> get streamTabControllerIndex => _tabControllerIndex.stream;

  ArticlePageBloc() {
    _incrementSize.listen((size) => _textSizeSink.add(++_textDefaultSize));
    _decrementSize.listen((size) => _textSizeSink.add(--_textDefaultSize));
  }

  @override
  void dispose() {
    _incrementSize.close();
    _decrementSize.close();
    _textSizeSubject.close();
  }
}
