

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mynotes/services/cloud/cloud_note.dart';
import 'package:mynotes/services/cloud/cloud_storage_constants.dart';
import 'package:mynotes/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage{
  
  final notes = FirebaseFirestore.instance.collection('notes');

Future<void> deleteNote({required String documentId}) async{
  try {
    notes.doc(documentId).delete();
  } catch (e) {
    throw CouldNotDeleteNoteException();
  }
}

Future<void> updateNote({
  required String documentId,
  required String text,
}) async{
  try{
  await  notes.doc(documentId).update({textFieldName: text});
  }catch(e){
    throw CouldNotUpdateNoteException();
  }
}



 Stream<Iterable<CloudNote>> allNotes({required String ownerUserID}) {
  final allNotes = notes
 .where(ownerUserIdFieldName, isEqualTo: ownerUserID)
 .snapshots()
 .map((event) => event.docs.map((doc) => CloudNote.fromSnapshot(doc))) ;
 
 return allNotes;
 }
 
  



  Future<CloudNote> createNewNote({required String ownerUserID}) async{
   final document = await notes.add({
      ownerUserIdFieldName:ownerUserID,
      textFieldName:'',
    });final fetchNote= await document.get();
    return CloudNote(
      documentId: fetchNote.id,
       ownerUserID: ownerUserID,
        text: '',);
  }


  static final FirebaseCloudStorage _shared = 
  FirebaseCloudStorage._sharedInstance();

  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}