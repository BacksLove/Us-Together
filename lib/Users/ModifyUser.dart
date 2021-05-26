import 'package:flutter/material.dart';
import 'package:us_together/Backend/Entities/User.dart';
import 'package:us_together/Backend/Implementations/UserProvider.dart';


class ModifyProfile extends StatefulWidget {
  User currentUser;

  ModifyProfile({this.currentUser});

  @override
  _ModifyProfileState createState() => _ModifyProfileState();
}

class _ModifyProfileState extends State<ModifyProfile> {
  UserProvider _userProvider = UserProvider();
  TextEditingController _firstnameController;
  TextEditingController _lastnameController;
  TextEditingController _usernameController;

  @override
  void initState() {
    _firstnameController = TextEditingController(text: "");
    _lastnameController = TextEditingController(text: "");
    _usernameController = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Modification du profil"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _lastnameController,
                  decoration: InputDecoration(
                      labelText: 'Nom',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                      focusColor: Theme.of(context).accentColor,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor),
                      ),
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: _firstnameController,
                  decoration: InputDecoration(
                    labelText: 'Prenom',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    focusColor: Theme.of(context).accentColor,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).accentColor),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    focusColor: Theme.of(context).accentColor,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).accentColor),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_lastnameController.text == "" || _firstnameController.text == "" || _usernameController.text == "") {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Un des champs est vide"),));
          } else {
            User modifyU = User();
            modifyU = widget.currentUser;
            modifyU.lastname = _lastnameController.text;
            modifyU.firstname = _firstnameController.text;
            modifyU.username = _usernameController.text;

            _userProvider.UpdateUser(modifyU);
            Navigator.pop(context);
          }
        },
        icon: Icon(Icons.check_circle_outline),
        label: Text("Valider", style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
