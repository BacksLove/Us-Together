import 'package:flutter/material.dart';
import 'package:us_together/Backend/Entities/User.dart';
import 'package:us_together/Backend/Implementations/EventProvider.dart';
import 'package:us_together/Backend/Implementations/SharedPreferences.dart';

class MyEventList extends StatefulWidget {
  @override
  _MyEventListState createState() => _MyEventListState();
}

class _MyEventListState extends State<MyEventList> {
  EventProvider _eventProvider = EventProvider();
  SPreferences _preferences = SPreferences();
  User currentUser = User();

  @override
  void initState() {
    _preferences.getCurrentUser().then((value){
      setState(() {
        currentUser = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: StreamBuilder(
        stream: _eventProvider.getFiveNextEvent(currentUser.email),
        builder: (context, snapshots) {
          return (snapshots.data == null) ? Text("Pas d'event a afficher") : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshots.data.documents.length,
            itemBuilder: (_, index) {
              return MyListElement(nom: snapshots.data.documents[index]["Name"], organisateur: currentUser.username, dateDebut: snapshots.data.documents[index]["StartDate"], icon: Icons.event);
            }
          );
        }
      ),
    );
  }
}

class MyListElement extends StatelessWidget {

  String nom;
  String dateDebut;
  String organisateur;
  IconData icon;

  MyListElement({this.nom, this.dateDebut, this.organisateur, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: new Card(
        elevation: 5,
        child: new Container(
          padding: new EdgeInsets.all(10.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new ListTile(
                leading: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(nom),
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Organisé par : " + organisateur,
                    style: TextStyle(
                      fontFamily: "Source Sans Pro",
                      color: Colors.grey
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text("Le : ${DateTime.parse(dateDebut).day.toString()}/${DateTime.parse(dateDebut).month.toString()}/${DateTime.parse(dateDebut).year.toString()}"),
                      Spacer(),
                      Text("A : ${DateTime.parse(dateDebut).hour.toString()}h${DateTime.parse(dateDebut).minute.toString()}")
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}