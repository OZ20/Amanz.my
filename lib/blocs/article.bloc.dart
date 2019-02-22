import 'bloc.provider.dart';
import 'package:rxdart/rxdart.dart';

class ArticlePageBloc extends BlocBase {

  double _textDefaultSize = 18;

  Subject<double> _incrementSize = PublishSubject();

  Sink<double> get incrementSizeSink => _incrementSize.sink;

  Subject<double> _decrementSize = PublishSubject();

  Sink<double> get decrementSizeSink => _decrementSize.sink;

  Subject<double> _textSizeSubject = PublishSubject();

  Sink<double> get _textSizeSink => _textSizeSubject.sink;

  Stream<double> get textSizeStream => _textSizeSubject.stream;

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
