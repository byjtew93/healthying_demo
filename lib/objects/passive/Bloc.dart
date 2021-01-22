import 'dart:async';

import 'package:rxdart/rxdart.dart';

class Bloc<T extends Object> {
  T _object;
  final _controller = BehaviorSubject<T>();

  Stream<T> get stream => _controller.stream.asBroadcastStream();

  Bloc.of(this._object) {
    update();
  }

  void update() {
    _controller.sink.add(this._object);
  }

  void dispose() => _controller.close();
}
