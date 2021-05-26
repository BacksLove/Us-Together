import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:us_together/Backend/Entities/User.dart';
import 'package:us_together/Backend/Entities/House.dart';
import 'package:us_together/Backend/Implementations/HouseProvider.dart';
import 'package:us_together/Backend/Implementations/SharedPreferences.dart';
import 'package:us_together/Backend/Implementations/UserProvider.dart';
import 'package:us_together/Houses/HouseDetail.dart';
import 'package:us_together/Houses/NewHouse.dart';


class HousesPage extends StatefulWidget {

  @override
  _HousesPageState createState() => _HousesPageState();
}

class _HousesPageState extends State<HousesPage> {
  TextEditingController codeController;
  bool _isAddRoomVisible = false;
  User currentUser;

  @override
  void initState() {
    codeController = TextEditingController(text: "");
    SPreferences().getCurrentUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Mes foyers'),
      ),
      body: SafeArea(
        child:
          Container(
            padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Gestion des foyers")
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/2.5,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.pinkAccent,
                        child: Text(
                          'Creer un foyer',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Source Sans Pro'
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CreateHouse())
                          );
                        },
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width/2.5,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.pinkAccent,
                        child: Text(
                          _isAddRoomVisible ? 'Annuler' : 'Rejoindre un foyer',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Source Sans Pro'
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isAddRoomVisible = !_isAddRoomVisible;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                _isAddRoomVisible ? Container(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                          labelText: "Code",
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
                        controller: codeController,
                      ),
                      RaisedButton(
                        color: Colors.pink,
                        child: Text('Ajouter',
                          style: TextStyle(color: Colors.white),),
                        onPressed: () async {
                          print(currentUser.email);
                          await HouseProvider().JoinHouse(currentUser.email, codeController.text).then((value) {
                            setState(() {
                              codeController.text = "";
                              _isAddRoomVisible = !_isAddRoomVisible;
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ) : SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Mes foyers")
                  ],
                ),
                SizedBox(height: 10,),
                (currentUser != null) ? Expanded(
                  //height: 400,
                  child: StreamBuilder(
                    stream: HouseProvider().GetUserHouses(currentUser.email),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const Text("Vous n'avez aucun foyer, rejoignez en un vite !");
                      return new ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) => buildCardFoyer(context, snapshot.data.documents[index])
                      );
                    },
                  ),
                ) : Container()
              ],
            ),
          ),
      ),
    );
  }

  Widget buildCardFoyer(BuildContext context, DocumentSnapshot house) {
    House houseToPass = House();
    houseToPass.idHouse = house['IdHouse'];
    houseToPass.idOwner = house['IdOwner'];
    houseToPass.name = house['Name'];
    houseToPass.description = house['Description'];
    houseToPass.createdDate = DateTime.parse(house['CreatedAt']);
    houseToPass.updatedDate = DateTime.parse(house['UpdatedAt']);
    houseToPass.users = List.from(house['Members']);

    return new SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HouseDetail(houseToPass))
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(house["Name"]),
                Text("Description : " + house['Description']),
              ],
            ),
          ),
        ),
      ),
    );
  }

}