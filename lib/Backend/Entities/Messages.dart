

import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {

  String _idMessage;
  String _idUser;
  String _username;
  String _idHouse;
  String _message;
  DateTime _createdDate;

  String get idMessage => _idMessage;

  set idMessage(String value) {
    _idMessage = value;
  }

  String get idUser => _idUser;

  DateTime get createdDate => _createdDate;

  set createdDate(DateTime value) {
    _createdDate = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  String get idHouse => _idHouse;

  set idHouse(String value) {
    _idHouse = value;
  }

  set idUser(String value) {
    _idUser = value;
  }


  String get username => _username;

  set username(String value) {
    _username = value;
  }

  fromDocumentSnapshot (DocumentSnapshot snapshot) {
    this.idMessage = snapshot.data["IdMessage"];
    this.idHouse = snapshot.data["IdHouse"];
    this.idUser = snapshot.data["IdUser"];
    this.username = snapshot.data["Username"];
    this.message = snapshot.data["Message"];
    this.createdDate = DateTime.parse(snapshot.data["CreatedDate"]);
  }

  Map<String, String> toMap() {
    Map<String,String> data = {
      "IdMessage" : this._idMessage,
      "IdUser" : this._idUser,
      "IdHouse" : this._idHouse,
      "Username" : this._username,
      "Message" : this._message,
      "CreatedDate" : this._createdDate.toString(),
    };
    return data;
}


}