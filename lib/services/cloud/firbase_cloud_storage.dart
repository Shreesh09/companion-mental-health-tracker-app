import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companionapp/services/cloud/cloud_note.dart';
import 'package:companionapp/services/cloud/cloud_storage_constants.dart';
import 'package:companionapp/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('notes');

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();

  factory FirebaseCloudStorage() => _shared;

  FirebaseCloudStorage._sharedInstance();

  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    DateTime now = DateTime.now();
    DateTime date =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
      dateFieldName: date.toString().substring(0, 16),
    });
    final fetchedNote = await document.get();
    return CloudNote(
      documentId: fetchedNote.id,
      ownerUserId: ownerUserId,
      text: '',
      date: date.toString().substring(0, 16),
    );
  }

  Future<Iterable<CloudNote>> getNotes({required String ownerUserId}) async {
    try {
      return await notes
          .where(
            ownerUserIdFieldName,
            isEqualTo: ownerUserId,
          )
          .orderBy(dateFieldName)
          .get()
          .then(
              (value) => value.docs.map((doc) => CloudNote.fromSnapShot(doc)));
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
  }

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) =>
      notes.snapshots().map((event) => event.docs
          .map((doc) => CloudNote.fromSnapShot(doc))
          .where((note) => note.ownerUserId == ownerUserId));

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      notes.doc(documentId).update({textFieldName: text});
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Future<void> deleteNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }
}
