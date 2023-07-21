import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companionapp/services/mood_tracker_db/cloud_storage_mood_constants.dart';
import 'cloud_mood.dart';
import 'cloud_storage_mood_exceptions.dart';

class FirebaseMoodCloudStorage {
  final moods = FirebaseFirestore.instance.collection('moods');

  static final FirebaseMoodCloudStorage _shared =
      FirebaseMoodCloudStorage._sharedInstance();

  factory FirebaseMoodCloudStorage() => _shared;

  FirebaseMoodCloudStorage._sharedInstance();

  Future<CloudMood> createNewMood(
      {required String ownerUserId,
      required String mood,
      required String activity}) async {
    DateTime now = DateTime.now();
    DateTime date = DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.second);
    final document = await moods.add({
      moodFieldName: mood,
      activityFieldName: activity,
      ownerUserIDFieldName: ownerUserId,
      dateMoodFieldName: date.toString().substring(0, 18),
    });
    final fetchedNote = await document.get();
    return CloudMood(
      documentId: fetchedNote.id,
      ownerUserId: ownerUserId,
      mood: fetchedNote.data()![moodFieldName],
      activity: fetchedNote.data()![activityFieldName],
      date: date.toString().substring(0, 18),
    );
  }

  Future<Iterable<CloudMood>> getMoods({required String ownerUserId}) async {
    try {
      return await moods
          .where(
            ownerUserIDFieldName,
            isEqualTo: ownerUserId,
          )
          .orderBy(dateMoodFieldName)
          .get()
          .then(
              (value) => value.docs.map((doc) => CloudMood.fromSnapShot(doc)));
    } catch (e) {
      throw CouldNotGetAllMoodsException();
    }
  }

  Stream<Iterable<CloudMood>> allMoods({required String ownerUserId}) =>
      moods.snapshots().map((event) => event.docs
          .map((doc) => CloudMood.fromSnapShot(doc))
          .where((note) => note.ownerUserId == ownerUserId));

  Future<void> deleteMood({required String documentId}) async {
    try {
      await moods.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteMoodException();
    }
  }
}
