import 'package:flutter/material.dart';
import 'package:us_together/Backend/Entities/Event.dart';
import 'package:us_together/Backend/Implementations/EventProvider.dart';
import 'package:us_together/Backend/Implementations/SharedPreferences.dart';


class EventDetail extends StatefulWidget {
  MyEvents currentEvent;

  EventDetail(this.currentEvent);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  int _participation;
  String idUser;
  EventProvider _eventProvider = EventProvider();
  SPreferences _preferences = SPreferences();

  @override
  void initState() {
    _eventProvider.isInEvent(widget.currentEvent.idEvent, idUser).then((value){
      if (value == true) {
        setState(() {
          _participation = 1;
        });
      } else {
        setState(() {
          _participation = 2;
        });
      }
    });
    _preferences.getString("currentUserEmail").then((value){
      idUser = value;
    });
    super.initState();
  }

  setSelectedParticipation (int value) {
    setState(() {
      _participation = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.currentEvent.name),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/images/event.jpg", height: 150, width: 600,),
                Card(
                  child: ListTile(
                    title: Text(widget.currentEvent.name),
                    subtitle: Text(widget.currentEvent.location),
                  ),
                ),
                SizedBox(height: 10,),
                Divider(),
                Card(
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("Je participe"),
                          Radio(
                            value: 1,
                            groupValue: _participation,
                            onChanged: (val) async {
                              setSelectedParticipation(val);
                              if (widget.currentEvent.idCreator != idUser)
                                await _eventProvider.joinEvent(widget.currentEvent.idEvent, idUser);
                            },
                          ),
                        ],
                      ),
                      SizedBox(width: 50,),
                      Column(
                        children: <Widget>[
                          Text("Je ne participe pas"),
                          Radio(
                            value: 2,
                            groupValue: _participation,
                            onChanged: (val) async {
                              setSelectedParticipation(val);
                              if (widget.currentEvent.idCreator != idUser)
                                await _eventProvider.quitEvent(widget.currentEvent.idEvent, idUser);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
                SizedBox(height: 10,),
                Text(widget.currentEvent.description),
                SizedBox(height: 10,),
                Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.calendar_today, color: Theme.of(context).accentColor,),
                        title: Text("${widget.currentEvent.startDate.day}, ${widget.currentEvent.startDate.month} ${widget.currentEvent.startDate.year}"),
                      ),
                      ListTile(
                        leading: Icon(Icons.schedule, color: Theme.of(context).accentColor,),
                        title: Text("${widget.currentEvent.startDate.hour}:${widget.currentEvent.startDate.minute} - ${widget.currentEvent.endDate.hour}:${widget.currentEvent.endDate.minute}"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Divider(),
                Text(
                  "Liste des membres",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: widget.currentEvent.users.length,
                    itemBuilder: (_,index) {
                      return Card(
                        child: ListTile(
                          title: Text(widget.currentEvent.users[index]),
                        ),
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {

          },
          label: Text("Inviter des membres"),
          icon: Icon(Icons.add),
          backgroundColor: Colors.pink,
      ),
    );
  }
}
