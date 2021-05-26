import 'package:flutter/material.dart';
import 'package:us_together/Backend/Entities/User.dart';
import 'package:us_together/Backend/Implementations/HouseProvider.dart';
import 'package:us_together/Backend/Implementations/SharedPreferences.dart';
import 'package:us_together/Houses/InvitePeople.dart';
import 'package:us_together/Backend/Entities/House.dart';


class CreateHouse extends StatefulWidget {
  @override
  _CreateHouseState createState() => _CreateHouseState();
}

class _CreateHouseState extends State<CreateHouse> {
  final SPreferences _preferences = SPreferences();
  TextEditingController _nomController;
  TextEditingController _descriptionController;
  String _idOwner;

  @override
  void initState() {
    _nomController = TextEditingController(text: "");
    _descriptionController = TextEditingController(text: "");
    _preferences.getString("currentUserEmail").then( (String name) {
      setState(() {
        this._idOwner = name;
      });
      print("Owner $_idOwner");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Création d'un foyer"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/flutter_home.png"),
              SizedBox(height: 40),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: _nomController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                          labelText: "Nom du foyer",
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
                      SizedBox(height: 20),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 5,
                        decoration: InputDecoration(
                            labelText: "Description",
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
                            hintMaxLines: 5
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_nomController.text.isEmpty || _descriptionController.text.isEmpty) {
            print("Au moins un champ est vide");
            Scaffold.
            of(context).
            showSnackBar(SnackBar(content: Text("Au moins un champs est vide")));
            return;
          }
          House houseEnt = House();
          houseEnt.idHouse = "";
          houseEnt.idOwner = _idOwner;
          houseEnt.name = _nomController.text;
          houseEnt.description = _descriptionController.text;
          houseEnt.createdDate = DateTime.now();
          houseEnt.updatedDate = DateTime.now();
          houseEnt.users = [_idOwner];
          await HouseProvider().AddHouse(houseEnt, _idOwner).then((result) {
            if (result != "") {
              print("Redirection");
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InvitePeople(idHouse: result))
              );
            } else {
              print("Un probleme s'est produit");
              return;
            }
          });
        },
        label: Text("Valider"),
        icon: Icon(Icons.check),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
