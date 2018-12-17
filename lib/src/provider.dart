import 'package:meta/meta.dart';

typedef Disposable<T>(T provider);

class Provider<T> {
  final T provider;
  final Disposable<T> _disposable;

  Provider({
    @required this.provider,
    @required Disposable<T> disposable,
  }) : _disposable = disposable;

  Type get type => T;

  void dispose() {
    _disposable(provider);
  }
}
