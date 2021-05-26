

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:us_together/Backend/Entities/Event.dart';

class User {

  String          _lastname;
  String          _firstname;
  String          _username;
  String          _email;
  String          _image;
  List<MyEvents>  _events;
  DateTime        _createdDate;
  DateTime        _updatedDate;
  String          _fcmToken;

  User();

  DateTime get updatedDate => _updatedDate;

  set updatedDate(DateTime value) {
    _updatedDate = value;
  }

  DateTime get createdDate => _createdDate;

  set createdDate(DateTime value) {
    _createdDate = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get firstname => _firstname;

  set firstname(String value) {
    _firstname = value;
  }

  String get lastname => _lastname;

  set lastname(String value) {
    _lastname = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get fcmToken => _fcmToken;

  set fcmToken(String value) {
    _fcmToken = value;
  }

  List<MyEvents> get events => _events;

  set events(List<MyEvents> value) {
    _events = value;
  }

  fromDocumenSnapshot(DocumentSnapshot datasnapshot) {
    this.firstname = datasnapshot.data['Firstname'];
    this.lastname = datasnapshot.data['Lastname'];
    this.username = datasnapshot.data['Username'];
    this.image = datasnapshot.data['Image'];
    this.email = datasnapshot.data['Email'];
    this.createdDate = DateTime.parse(datasnapshot.data['CreatedAt']);
    this.updatedDate = DateTime.parse(datasnapshot.data['UpdatedAt']);
    this.fcmToken = datasnapshot['FcmToken'];
  }

  Map<String,Object> toMap() {
     Map<String, Object> data = <String,Object> {
        "Lastname" : this.lastname,
        "Firstname" : this.firstname,
        "Username" : this.username,
        "Image" : this.image,
        "Email" : this.email,
        "CreatedAt" : this.createdDate.toIso8601String(),
        "UpdatedAt" : this.createdDate.toIso8601String(),
        "FcmToken" : this.fcmToken
     };
     return data;
  }


}