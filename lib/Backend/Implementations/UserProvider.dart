import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:us_together/Backend/Entities/User.dart';


class UserProvider {

  final CollectionReference _collectionReference = Firestore.instance.collection("Users");

  bool AddUser(User user) {
    Map<String, Object> data = user.toMap();
    _collectionReference.document(user.email).setData(data).whenComplete((){
      return true;
    }).catchError((e) => print(e));
    return false;
  }

  bool RemoveFromHouse(String email, String idHouse) {
    _collectionReference.document(email).collection("Houses").document(idHouse).delete().whenComplete(() {
      return true;
    }).catchError((e) => print(e));
    return false;
  }

  Future<void> UpdateUser(User user) {
    user.updatedDate = DateTime.now();
    Map<String, Object> data = user.toMap();
    _collectionReference.document(user.email).updateData(data).whenComplete((){
      print("Utilisateur modifié");
    }).catchError((e) => print(e));
  }

  bool DeleteUser(String email) {
    _collectionReference.document(email).delete().whenComplete((){
      return true;
    }).catchError((e) => print(e));
    return false;
  }

  Future<User> GetUser(String email) async {
    User user = new User();
    await _collectionReference.document(email).get().then((datasnapshot) {
      if (datasnapshot.exists) {
        user.fromDocumenSnapshot(datasnapshot);
      }
    });
    return user;
  }

  Future<bool> UserExist(String email) async {
    await _collectionReference.document(email).get().then((datasnapshot) {
      if (datasnapshot.data.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<List<User>> getAllUserByList(List<String> idUsers) async {
    List<User> users = [];
    for (var idUser in idUsers) {
      await _collectionReference.document(idUser).get().then( (user) {
        User currentUser = User();
        currentUser.fromDocumenSnapshot(user);
        users.add(currentUser);
      });
    }
    return users;
  }
  

}
