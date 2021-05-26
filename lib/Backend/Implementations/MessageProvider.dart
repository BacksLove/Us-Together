import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:us_together/Backend/Entities/Messages.dart';

class MessageProvider {

  final CollectionReference _collectionReference = Firestore.instance.collection("Messages");
  final _db = Firestore.instance;

  Future<bool> addMessage(Messages message) async {
    try {
      String uid = await _collectionReference.document(message.idHouse).collection("Messages").document().documentID;
      message.idMessage = uid;
      await _collectionReference.document(message.idHouse).collection("Messages").document(message.idMessage).setData(
          message.toMap()).whenComplete(() {
        print("le message a été envoyé");
      }).catchError((e) => print(e));
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot> getAllMessages(String idHouse) async* {
    yield* _db.collection("Messages").document(idHouse).collection("Messages").orderBy("CreatedDate", descending: true).snapshots();
  }



}