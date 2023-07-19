import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companionapp/services/mood_tracker_db/cloud_storage_mood_constants.dart';
import 'package:companionapp/services/mood_tracker_db/mood_image_contants.dart';

const moodList = [happy, neutral, sad, angry];
const activityList = [
  family,
  friends,
  excercise,
  clean,
  date,
  eat,
  gaming,
  movies,
  reading,
  relax,
  shop,
  sports
];

class CloudMood {
  final String documentId;
  final String ownerUserId;
  final String mood;
  final String activity;
  final String date;

  const CloudMood(
      {required this.documentId,
      required this.ownerUserId,
      required this.mood,
      required this.date,
      required this.activity});

  CloudMood.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIDFieldName],
        mood = snapshot.data()[moodFieldName] as String,
        activity = snapshot.data()[activityFieldName] as String,
        date = snapshot.data()[dateMoodFieldName];
}
