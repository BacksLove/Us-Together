import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:us_together/Backend/Entities/Event.dart';
import 'package:us_together/Backend/Implementations/EventProvider.dart';
import 'package:us_together/Backend/Implementations/SharedPreferences.dart';
import 'package:us_together/Events/CreateEvent.dart';
import 'package:us_together/Events/EventDetail.dart';

class CalendarHouse extends StatefulWidget {
  String _idHouse;

  CalendarHouse(this._idHouse);
  
  @override
  _CalendarHouseState createState() => _CalendarHouseState();
}

class _CalendarHouseState extends State<CalendarHouse> {

  @override
  void initState() {
    print(widget._idHouse);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream: EventProvider().getAllRoomEvents(widget._idHouse),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Il n'y a rien de partagé dans ce foyer");
              return new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) => eventWidget(context, snapshot.data.documents[index])
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateEvent(widget._idHouse))
          );
        },
        label: Text("Creer un évènement"),
        icon: Icon(Icons.event),
        backgroundColor: Colors.pink,
      ),
    );
  }
  
  Widget eventWidget(BuildContext context, DocumentSnapshot event) {
    MyEvents ev = MyEvents();
    ev.fromDocumentSnapshot(event);
    String dateDebut = event["StartDate"] != "" ? "${DateTime.parse(event['StartDate']).day} - ${DateTime.parse(event['StartDate']).month} - ${DateTime.parse(event['StartDate']).year}" : "Pas de date renseignée";
    String heureDebut = event["StartDate"] != "" ? "${DateTime.parse(event['EndDate']).hour} : ${DateTime.parse(event['EndDate']).minute}" : "Pas d'heure rensignée";
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventDetail(ev))
            );
          },
          child: new Card (
            elevation: 5,
            margin: EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: new BorderRadius.circular(20.0),
                  child: Image.network(
                    event["Image"] != null ? event["Image"] : "https://cdn.pixabay.com/photo/2013/11/03/08/05/cheers-204742__480.jpg" ,
                    fit: BoxFit.fill,
                    height: 250,
                    width: 700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: ScreenUtil.getInstance().setHeight(5),),
                      Text(
                        event["Name"],
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "Source Sans Pro",
                            color: Colors.white
                        ),
                      ),
                      SizedBox(height: ScreenUtil.getInstance().setHeight(50),),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          SizedBox(width: ScreenUtil.getInstance().setWidth(25),),
                          Text(
                            event["Location"] != "" ? event["Location"] : "Pas de lieu renseigné",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Source Sans Pro",
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil.getInstance().setHeight(10),),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.schedule,
                            color: Colors.white,
                          ),
                          SizedBox(width: ScreenUtil.getInstance().setWidth(25),),
                          Text( dateDebut ,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Source Sans Pro",
                                color: Colors.white
                            ),
                          ),
                          SizedBox(width: ScreenUtil.getInstance().setWidth(25),),
                          Text( heureDebut ,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Source Sans Pro",
                                color: Colors.white
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(30),)
      ],
    );
  }
}
