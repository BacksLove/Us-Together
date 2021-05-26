import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:us_together/Backend/Entities/Member.dart';


class MemberProvider {
  
  final CollectionReference _collectionReference = Firestore.instance.collection("Members");
  
  Future<bool> AddMember (Member member) async {
    try {
      Map<String, Object> data = member.toMap();
      await _collectionReference.add(data).then((value) {
        print("le membre a été ajouté correctement. Valeur: $value");
        return true;
      });
    } catch (e) {
      return false;
    }
    return false;
  }

  
}