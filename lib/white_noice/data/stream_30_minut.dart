import 'dart:async';
import 'dart:developer';

class TimerIsolate {
  late StreamController<int> _timerController;
  late Stream<int> timerStream;

  TimerIsolate() {
    _timerController = StreamController<int>();
    timerStream = _timerController.stream;
  }

  void startTimer() {
    const Duration delay = Duration(seconds: 5);

    Future<void> delayedFunction() async {
      await Future.delayed(delay);
      _timerController.add(0);
      stopTimer();
    }

    delayedFunction();
  }

  void stopTimer() {
    _timerController.close();

    log(_timerController.isClosed.toString(),
        name: 'void stopTimer LOG from TimerIsolate');
    print('Timer stopped.');
    print('NecroMantia FIRST');
    _timerController = StreamController<int>();
    timerStream = _timerController.stream;
    
  }

  bool get isClosed => _timerController.isClosed;
  bool get isPaused => _timerController.isPaused;
}
