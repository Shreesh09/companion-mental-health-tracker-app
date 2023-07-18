import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companionapp/services/cloud/cloud_storage_constants.dart';

class CloudNote {
  final String documentId;
  final String ownerUserId;
  final String date;
  final String text;
  const CloudNote({
    required this.documentId,
    required this.ownerUserId,
    required this.text,
    required this.date,
  });

  CloudNote.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        text = snapshot.data()[textFieldName] as String,
        date = snapshot.data()[dateFieldName] as String;
}
