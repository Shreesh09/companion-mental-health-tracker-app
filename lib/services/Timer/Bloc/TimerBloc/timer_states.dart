abstract class TimerState {
  final double? duration;
  const TimerState({this.duration});
}

class TimerStateUninitialized extends TimerState {
  const TimerStateUninitialized() : super();
}

class TimerStateRunning extends TimerState {
  const TimerStateRunning() : super();
}

class TimerStateStopped extends TimerState {
  final Exception? exception;
  const TimerStateStopped({required this.exception}) : super();
}
