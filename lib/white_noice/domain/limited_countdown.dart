import 'dart:async';

class LimitedCountdown {
  late Timer _timer;
  final Duration delay;

  LimitedCountdown({required this.delay});

  void startTimer(Function() callback) {
    _timer = Timer.periodic(delay, (_) {
      callback();
    });
  }

  Future<void> stopTimer() async {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }
}
