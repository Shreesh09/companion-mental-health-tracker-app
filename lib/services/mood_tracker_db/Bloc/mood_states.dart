abstract class MoodState {
  final String? mood;
  final String? activity;
  const MoodState({required this.mood, required this.activity});
}

class MoodStateNotSet extends MoodState {
  final Exception? exception;
  const MoodStateNotSet(
      {required this.exception,
      required String? mood,
      required String? activity})
      : super(mood: mood, activity: activity);
}

class MoodStateSet extends MoodState {
  const MoodStateSet({required String? mood, required String? activity})
      : super(mood: mood, activity: activity);
}
