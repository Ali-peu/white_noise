import 'dart:async';

class LimitedCountdown {
  late Timer _timer;
  bool _isPaused = false;

  LimitedCountdown();

  void startTimer(Function() callback) {
    
    const Duration delay = Duration(seconds: 6);
    // _timer = Timer(delay, callback);
    _timer = Timer.periodic(delay, (Timer timer) {
      if (!_isPaused) {
        callback();
      }
    });
  }

  void stopTimer() {
    if (_timer.isActive) {
      _timer.cancel();
      print('Timer stopped.');
    }
  }

  void pauseTimer() {
    _isPaused = true;
    print('Timer paused.');
  }

  void resumeTimer() {
    _isPaused = false;
    print('Timer resumed.');
  }
}
