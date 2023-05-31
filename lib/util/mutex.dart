import 'dart:async';

import 'dart:collection';

class Mutex {
  Queue<Completer<void>> _waitQueue = Queue();
  bool _locked = false;

  Future<void> acquire() async {
    final completer = Completer<void>();
    if (!_locked) {
      _locked = true;
      completer.complete();
    } else {
      _waitQueue.add(completer);
    }
    await completer.future;
  }

  void release() {
    if (_waitQueue.isNotEmpty) {
      _waitQueue.removeFirst().complete();
    } else {
      _locked = false;
    }
  }
}