import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:us_together/Backend/Entities/House.dart';

class HouseProvider {

  final CollectionReference _collectionReference = Firestore.instance.collection("Houses");
  final _db = Firestore.instance;

  Future<String> AddHouse(House house, String email) async {
    String res = "";
    try {
      String id = await _collectionReference
          .document()
          .documentID;
      house.idHouse = id;
      res = id;
      house.code = id.substring(0, 6);
      Map<String, Object> data = house.toMap();
      await _collectionReference.document(id).setData(data).whenComplete(() {
        print("House ajouté dans les houses");
      }).catchError((e) => print(e));
      /*await _db.collection("Users").document(email).collection("User Houses").add(data).whenComplete(() {
        print("House ajouté dans le users");
      }).catchError((e) => print(e));*/

      return res;
    } catch (e) {
      return "";
    }
  }

  Future<bool> JoinHouse(String email, String idHouse) async {
    try {
      House currentHouse = House();
      await _collectionReference.where("Code", isEqualTo: idHouse).getDocuments().then((snapshots) {
        for (var snapshot in snapshots.documents) {
          currentHouse.idHouse = snapshot.data["IdHouse"];
          currentHouse.idOwner = snapshot.data["IdOwner"];
          currentHouse.name = snapshot.data["Name"];
          currentHouse.code = snapshot.data["Code"];
          currentHouse.description = snapshot.data["Description"];
          currentHouse.createdDate = DateTime.parse(snapshot.data["CreatedAt"]);
          currentHouse.updatedDate = DateTime.now();
          currentHouse.users = List.from(snapshot.data["Members"]);
        }
      });
      currentHouse.users.add(email);
      print(currentHouse.toMap());
      await _collectionReference.document(currentHouse.idHouse).setData(currentHouse.toMap()).whenComplete(() {
        return true;
      }).catchError((e) { return false;});
      return true;
    } catch (e) {
      print('probleme');
      return false;
    }
  }

  Future<bool> UpdateHouse(House house) async {
    try {
      house.updatedDate = DateTime.now();
      Map<String, String> data = house.toMap();
      await _collectionReference.document(house.idHouse)
          .updateData(data)
          .whenComplete(() {
        return true;
      }).catchError((e) => print(e));
      return false;
    } catch(e) {}
  }

  bool DeleteHouse(String idHouse) {
    _collectionReference.document(idHouse).delete().whenComplete(() {
      return true;
    }).catchError((e) => print(e));
  }

  bool HouseExist (String id) {
    _collectionReference.document(id).get().then((datasnapshot) {
      if (datasnapshot.exists)
        return true;
      else
        return false;
    }).catchError((e) => print(e));
    return false;
  }

  Future<House> GetHouseWithId(String id) async {
    House currentHouse = House();
    try {
      await _collectionReference.document(id).get().then((datasnapshot) {
        if (datasnapshot.exists) {
          currentHouse.idHouse = datasnapshot.data['IdHouse'];
          currentHouse.idOwner = datasnapshot.data['IdOwner'];
          currentHouse.name = datasnapshot.data['Name'];
          currentHouse.description = datasnapshot.data['Description'];
          currentHouse.createdDate = datasnapshot.data['CreatedDate'];
          currentHouse.updatedDate = datasnapshot.data['UpdatedDate'];
          currentHouse.users = datasnapshot.data["Members"];
          currentHouse.code = datasnapshot.data["Code"];
          //return currentHouse;
        }
      }).catchError((e) => print(e));
      return currentHouse;;
    } catch(e) {
      return null;
    }
  }

  Stream<QuerySnapshot> GetUserHouses(String email) async* {
   yield* _db.collection("Houses").where("Members", arrayContains: email).snapshots();
  }



}