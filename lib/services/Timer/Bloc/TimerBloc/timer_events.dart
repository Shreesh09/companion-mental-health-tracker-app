import 'package:flutter/material.dart';

abstract class TimerEvent {
  const TimerEvent();
}

class TimerEventStart extends TimerEvent {
  const TimerEventStart() : super();
}

class TimerEventStop extends TimerEvent {
  final BuildContext? context;
  const TimerEventStop({this.context}) : super();
}

class TimerEventSet extends TimerEvent {
  final int duration;
  const TimerEventSet({required this.duration}) : super();
}
