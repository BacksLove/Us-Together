import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'User.dart';

class MyEvents {

  String        _idEvent;
  String        _name;
  String        _description;
  String        _idCreator;
  String        _idRoom;
  String        _image;
  String        _location;
  List<String>  _users;
  DateTime      _startDate;
  DateTime      _endDate;
  //TimeOfDay     _startHour;
  //TimeOfDay     _endHour;
  DateTime      _createdDate;

  String get idEvent => _idEvent;

  set idEvent(String value) {
    _idEvent = value;
  }

  String get name => _name;

  DateTime get createdDate => _createdDate;

  set createdDate(DateTime value) {
    _createdDate = value;
  }

  DateTime get endDate => _endDate;

  set endDate(DateTime value) {
    _endDate = value;
  }

  DateTime get startDate => _startDate;

  set startDate(DateTime value) {
    _startDate = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get idRoom => _idRoom;

  set idRoom(String value) {
    _idRoom = value;
  }

  String get idCreator => _idCreator;

  set idCreator(String value) {
    _idCreator = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  set name(String value) {
    _name = value;
  }

  List<String> get users => _users;

  set users(List<String> value) {
    _users = value;
  }

  String get location => _location;

  set location(String value) {
    _location = value;
  }


  /*TimeOfDay get startHour => _startHour;

  set startHour(TimeOfDay value) {
    _startHour = value;
  }

  TimeOfDay get endHour => _endHour;

  set endHour(TimeOfDay value) {
    _endHour = value;
  }*/

  fromDocumentSnapshot (DocumentSnapshot snapshot) {
    this.idEvent = snapshot.data['IdEvent'];
    this.idRoom = snapshot.data['IdRoom'];
    this.idCreator = snapshot.data['IdCreator'];
    this.name = snapshot.data['Name'];
    this.description = snapshot.data['Description'];
    this.location = snapshot.data['Location'];
    this.users = List.from(snapshot.data['Members']);
    this.image = snapshot.data['Image'];
    this.startDate = DateTime.parse(snapshot.data['StartDate']);
    this.endDate = DateTime.parse(snapshot.data['EndDate']);
    //this.startHour = TimeOfDay.fromDateTime(snapshot.data['StartHour']);
    //this.endHour = snapshot.data['EndHour'];
    this.createdDate = DateTime.parse(snapshot.data['CreatedAt']);
  }

  Map<String, Object> toMap() {
    Map<String, Object> data = {
      "IdEvent" : this._idEvent,
      "IdRoom" : this._idRoom,
      "IdCreator" : this._idCreator,
      "Name" : this._name,
      "Description": this._description,
      "Location": this._location,
      "Members": this._users,
      "Image": this._image,
      "StartDate": this._startDate.toString(),
      "EndDate": this._endDate.toString(),
      //"StartHour" : this._startHour.toString(),
      //"EndHour" : this._endHour.toString(),
      "CreatedAt": this._createdDate.toString()
    };
    return data;
  }

}