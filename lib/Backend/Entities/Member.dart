

class Member {

  String _idUser;
  String _idHouse;

  String get idUser => _idUser;

  set idUser(String value) {
    _idUser = value;
  } //Member({idUser : this._idUser, idHouse: this._idHouse});

  String get idHouse => _idHouse;

  set idHouse(String value) {
    _idHouse = value;
  }


  Map <String, String> toMap() {
    Map<String, String> data = {
      "IdHouse" : _idHouse,
      "IdUser" : _idUser
    };
    return data;
  }

}