
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynotes/services/cloud/cloud_storage_constants.dart';
import 'package:flutter/foundation.dart';

@immutable
class CloudNote{
  final String documentId;
  final String ownerUserID;
  final String text;

  const CloudNote({
    required this.documentId,
    required this.ownerUserID,
    required this.text
  });

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) :
  documentId = snapshot.id,
  ownerUserID=snapshot.data()[ownerUserIdFieldName],
  text= snapshot.data()[textFieldName] as String;
}