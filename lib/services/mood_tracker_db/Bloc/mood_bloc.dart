import 'package:companionapp/services/mood_tracker_db/Bloc/mood_events.dart';
import 'package:companionapp/services/mood_tracker_db/Bloc/mood_states.dart';
import 'package:companionapp/services/mood_tracker_db/cloud_mood.dart';
import 'package:companionapp/services/mood_tracker_db/firbase_cloud_storage_mood.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cloud_storage_mood_exceptions.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  MoodBloc({
    required FirebaseMoodCloudStorage provider,
    required String ownerUserId,
  }) : super(const MoodStateNotSet(
            exception: null, mood: null, activity: null)) {
    on<MoodEventSetMood>(
      (event, emit) {
        if (moodList.contains(event.newMood)) {
          if (state.activity != null) {
            emit(MoodStateSet(mood: event.newMood, activity: state.activity));
          } else {
            emit(MoodStateNotSet(
                mood: event.newMood, activity: null, exception: null));
          }
        } else {
          emit(MoodStateNotSet(
              exception: InvalidMoodException(),
              mood: state.mood,
              activity: state.activity));
        }
      },
    );
    on<MoodEventUnSetMood>(
      (event, emit) {
        emit(MoodStateNotSet(
            exception: null, mood: null, activity: state.activity));
      },
    );

    on<MoodEventSetActivity>(
      (event, emit) {
        if (activityList.contains(event.newActivity)) {
          if (state.mood != null) {
            emit(MoodStateSet(mood: state.mood, activity: event.newActivity));
          } else {
            emit(MoodStateNotSet(
                mood: state.mood,
                activity: event.newActivity,
                exception: null));
          }
        } else {
          emit(MoodStateNotSet(
              exception: InvalidActivityException(),
              mood: state.mood,
              activity: state.activity));
        }
      },
    );
    on<MoodEventUnSetActivity>(
      (event, emit) {
        emit(MoodStateNotSet(
            exception: null, mood: state.activity, activity: null));
      },
    );
    on<MoodEventLog>((event, emit) async {
      if (state is MoodStateSet) {
        await provider.createNewMood(
            ownerUserId: ownerUserId,
            mood: state.mood!,
            activity: state.activity!);
      } else {
        emit(MoodStateNotSet(
            exception: MoodNotSetException(),
            mood: state.mood,
            activity: state.activity));
      }
    });
  }
}
