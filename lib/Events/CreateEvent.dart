import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:us_together/Backend/Entities/Event.dart';
import 'package:us_together/Backend/Implementations/EventProvider.dart';
import 'package:us_together/Backend/Implementations/SharedPreferences.dart';



class CreateEvent extends StatefulWidget {
  String _idHouse;

  CreateEvent(this._idHouse);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {

  List <String> typesEvent = ["Fete", "Repas", "Reunion", "Sortie", "Mariage", "Activité"];
  int _selectedEvent = 0;
  DateTime _dateDebut;
  int _heureDebut;
  int _minuteDebut;
  DateTime _dateFin;
  int _heureFin;
  int _minuteFin;
  TextEditingController nameController;
  TextEditingController descriptionController;
  TextEditingController locationController;


  @override
  void initState() {
    nameController = TextEditingController(text: "");
    descriptionController = TextEditingController(text: "");
    locationController = TextEditingController(text: "");
  }

  Future<Null> selectDate (BuildContext context, int which) async {

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2040)
    );

    if (which == 1 && (picked != null && picked != _dateDebut)) {
      print("dateDebut choisie $picked");
      setState(() {
        _dateDebut = picked;
      });
    }

    if (which == 2 && (picked != null && picked != _dateFin)) {
      print("dateFin choisie $picked");
      setState(() {
        _dateFin = picked;
      });
    }

  }

  Future<Null> selectTime (BuildContext context, int which) async {

    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );

    if (which == 1 && (picked != null && picked != _heureDebut)) {
      print("heureDebut choisie $picked");
      setState(() {
        _heureDebut = picked.hour;
        _minuteDebut = picked.minute;
      });
    }

    if (which == 2 && (picked != null && picked != _heureFin)) {
      print("heureFin choisie $picked");
      setState(() {
        _heureFin = picked.hour;
        _minuteFin = picked.minute;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Nouvel évènement"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset("assets/images/flutter_calendar.png"),
                SizedBox(height: 20,),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Nom",
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
                  controller: descriptionController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
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
                  ),
                ),
                SizedBox(height: 20,),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Début : Le ", style: TextStyle(color: Theme.of(context).accentColor),),
                            (_dateDebut != null) ?
                            GestureDetector(
                              onTap: () {
                                selectDate(context, 1);
                                },
                              child: Text("${_dateDebut.day}/${_dateDebut.month}/${_dateDebut.year}", style: TextStyle(fontSize: 20),),
                            ) :
                            ButtonTheme(
                              minWidth: 100,
                              buttonColor: Theme.of(context).accentColor,
                              child: RaisedButton(
                                onPressed: (){
                                  selectDate(context, 1);
                                } ,
                                child: Text(
                                  "Date",
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(" à ", style: TextStyle(color: Theme.of(context).accentColor),),
                            SizedBox(width: 10,),
                            (_heureDebut != null) ?
                            GestureDetector(
                              onTap: () {
                                selectTime(context, 1);
                              },
                              child: Text("$_heureDebut:$_minuteDebut", style: TextStyle(fontSize: 20)),
                            ) :
                            ButtonTheme(
                              minWidth: 100,
                              buttonColor: Theme.of(context).accentColor,
                              child: RaisedButton(
                                onPressed: (){
                                  selectTime(context, 1);
                                } ,
                                child: Text(
                                  "Heure",
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Fin : Le ", style: TextStyle(color: Theme.of(context).accentColor),),
                            (_dateFin != null) ?
                            GestureDetector(
                              onTap: () {
                                selectDate(context, 2);
                              },
                              child: Text("${_dateFin.day}/${_dateFin.month}/${_dateFin.year}", style: TextStyle(fontSize: 20)) ,
                            ) :
                            ButtonTheme(
                              minWidth: 100,
                              buttonColor: Theme.of(context).accentColor,
                              child: RaisedButton(
                                onPressed: (){
                                  selectDate(context, 2);
                                } ,
                                child: Text(
                                  "Date",
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(" à ", style: TextStyle(color: Theme.of(context).accentColor),),
                            SizedBox(width: 10,),
                            (_heureFin != null) ?
                            GestureDetector(
                              onTap: () {
                                selectTime(context, 2);
                              },
                              child: Text("$_heureFin:$_minuteFin", style: TextStyle(fontSize: 20))  ,
                            ) :
                            ButtonTheme(
                              minWidth: 100,
                              buttonColor: Theme.of(context).accentColor,
                              child: RaisedButton(
                                onPressed: (){
                                  selectTime(context, 2);
                                } ,
                                child: Text(
                                  "Heure",
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: "Lieu",
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
        onPressed: () {
          if (nameController.text == "" || descriptionController.text == "" || locationController.text == "") {
            print("Les champs sont vides");
            return;
          }
          MyEvents newEvent = MyEvents();
          newEvent.name = nameController.text;
          newEvent.idRoom = widget._idHouse;
          newEvent.description = descriptionController.text;
          newEvent.location = locationController.text;
          newEvent.startDate = DateTime(_dateDebut.year, _dateDebut.month, _dateDebut.day, _heureDebut, _minuteDebut);
          newEvent.endDate = DateTime(_dateFin.year, _dateFin.month, _dateFin.day, _heureFin, _minuteFin);
          newEvent.createdDate = DateTime.now();

          EventProvider().AddEvent(newEvent).then( (value) {
            print("T'es génial");
            Navigator.pop(context);
          });
        },
        label: Text("Valider"),
        icon: Icon(Icons.check_box),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
