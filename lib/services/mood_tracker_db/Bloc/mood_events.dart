abstract class MoodEvent {
  const MoodEvent();
}

class MoodEventSetMood extends MoodEvent {
  final String newMood;
  const MoodEventSetMood({required this.newMood}) : super();
}

class MoodEventUnSetMood extends MoodEvent {
  const MoodEventUnSetMood() : super();
}

class MoodEventSetActivity extends MoodEvent {
  final String newActivity;
  const MoodEventSetActivity({required this.newActivity}) : super();
}

class MoodEventUnSetActivity extends MoodEvent {
  const MoodEventUnSetActivity() : super();
}

class MoodEventLog extends MoodEvent {
  const MoodEventLog() : super();
}
