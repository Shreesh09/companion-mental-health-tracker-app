import 'dart:async';

import 'package:companionapp/services/Timer/timer_exceptions.dart';

typedef Time = void Function();

class TimerElapsed {
  final int time;
  TimerElapsed({required this.time});
}

class TimerService {
  Timer? countdownTimer;
  final StreamController<TimerElapsed> _streamController =
      StreamController.broadcast();
  Duration duration;
  int? seconds;

  static final _shared = TimerService._sharedInstance();
  TimerService._sharedInstance() : duration = const Duration(seconds: 1);
  factory TimerService() => _shared;

  void setTimer({required int time}) {
    seconds = time;
  }

  void startTimer() {
    if (seconds == null || seconds == 0) {
      throw TimerNotSetException();
    } else {
      print("started");
      countdownTimer = Timer.periodic(
        duration,
        (_) {
          //print(seconds);
          seconds = seconds! - 1;
          _streamController.add(TimerElapsed(time: seconds!));
          if (seconds == 0) countdownTimer!.cancel();
          //_streamController.close();
        },
      );
    }
  }

  Stream<TimerElapsed> getTime() {
    //print(seconds);
    if (countdownTimer != null && countdownTimer!.isActive) {
      return _streamController.stream;
    } else {
      throw TimerNotSetException();
    }
  }

  void stopTimer() {
    countdownTimer!.cancel();
  }

  void resetTimer() {
    countdownTimer = null;
  }
}
