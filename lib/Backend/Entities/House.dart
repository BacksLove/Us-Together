import 'package:us_together/Backend/Entities/User.dart';

class House {

  String        _idHouse;
  String        _idOwner;
  String        _name;
  String        _description;
  String        _code;
  List<String>  _users;
  DateTime      _createdDate;
  DateTime      _updatedDate;

  String get idHouse => _idHouse;

  set idHouse(String value) {
    _idHouse = value;
  }

  String get idOwner => _idOwner;

  DateTime get updatedDate => _updatedDate;

  set updatedDate(DateTime value) {
    _updatedDate = value;
  }

  DateTime get createdDate => _createdDate;

  set createdDate(DateTime value) {
    _createdDate = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  set idOwner(String value) {
    _idOwner = value;
  }

  List<String> get users => _users;

  set users(List<String> value) {
    _users = value;
  }


  String get code => _code;

  set code(String value) {
    _code = value;
  }

  Map<String,Object> toMap() {
    Map<String,Object> data = {
      "IdHouse" : this._idHouse,
      "IdOwner" : this._idOwner,
      "Name" : this._name,
      "Code" : this.code,
      "Description" : this._description,
      "CreatedAt" : this.createdDate.toIso8601String(),
      "UpdatedAt" : this.createdDate.toIso8601String(),
      "Members" : _users
    };

    return data;
  }

}