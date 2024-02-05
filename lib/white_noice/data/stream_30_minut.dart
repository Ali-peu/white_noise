import 'dart:async';

class TimerIsolate {
  late StreamController<int> _timerController;
  late Stream<int> timerStream;
  int counter = 0;

  TimerIsolate() {
    _timerController = StreamController<int>();
    timerStream = _timerController.stream;
    startTimer();
  }

  void startTimer() {
    const Duration delay = Duration(seconds: 1);

    Future<void> delayedFunction() async {
      await Future.delayed(delay);
      counter++;
      _timerController.add(counter);

      if (counter <= 5) {
        startTimer();
      } else {
        print('HERE WE CLOSE TIMER');
        stopTimer();
      }
    }

    delayedFunction();
  }

  void stopTimer() {
    _timerController.close();
    print('Timer stopped.');
    print('NecroMantia FIRST');
    _timerController = StreamController<int>();
    timerStream = _timerController.stream;
    if (_timerController.isClosed) {
      print('NecroMantia SECOND?');
      _timerController = StreamController<int>();
    }
  }
}
