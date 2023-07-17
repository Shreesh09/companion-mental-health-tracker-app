abstract class TimerEvent {
  const TimerEvent();
}

class TimerEventStart extends TimerEvent {
  const TimerEventStart() : super();
}

class TimerEventStop extends TimerEvent {
  const TimerEventStop() : super();
}

class TimerEventSet extends TimerEvent {
  final int duration;
  const TimerEventSet({required this.duration}) : super();
}
