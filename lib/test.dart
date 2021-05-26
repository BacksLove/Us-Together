import 'package:flutter/material.dart';
import 'package:us_together/Backend/Entities/Event.dart';


class EventDetailTest extends StatefulWidget {
  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetailTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Anniversaire"),
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
                    title: Text("Anniv"),
                    subtitle: Text("Maison"),
                  ),
                ),
                SizedBox(height: 10,),
                Divider(),
                Card(
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        value: 0,
                        groupValue: 10,
                        onChanged: (val) {

                        },
                      ),
                      SizedBox(width: 50,),
                      Radio(
                        value: 1,
                        groupValue: 10,
                        onChanged: (val) {

                        },
                      ),
                    ],
                  ),
                ),
                Text(
                  "Description",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
                SizedBox(height: 10,),
                Text("Okokok"),
                SizedBox(height: 10,),
                Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.calendar_today, color: Theme.of(context).accentColor,),
                        title: Text("15 Mai 2020"),
                      ),
                      ListTile(
                        leading: Icon(Icons.schedule, color: Theme.of(context).accentColor,),
                        title: Text("18h00 - 19h00")
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
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
                      itemCount: 2,
                      itemBuilder: (_,index) {
                        return Card(
                          child: ListTile(
                            title: Text("Membre $index"),
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

/*void theFunctions() async {
  await _eventProvider.getEventFromCalendar("bacar938@gmail.com").then((value){
    setState(() {
      myEvent = value;
    });
    while (myEvent.isNotEmpty) {
      sortedEvent.clear();
      DateTime beforeParse = myEvent.first.startDate;
      DateTime dateActu = DateTime(beforeParse.year, beforeParse.month, beforeParse.day);
      for (int i = 0 ; i < myEvent.length ; i++) {
        DateTime cbeforeParse = myEvent[i].startDate;
        DateTime dateToCompare = DateTime(cbeforeParse.year, cbeforeParse.month, cbeforeParse.day);
        if (dateToCompare == dateActu) {
          sortedEvent.add(myEvent[i]);
          myEvent.removeAt(i);
        }
      }
      setState(() {
        myEventFinal.addAll( {
          dateActu : sortedEvent
        } );
      });
    }
    print(myEventFinal.toString());
  });
}

return ListView.builder(
itemCount: _selectedEvents.length,
itemBuilder: (context, index) {
return Card (
child: ListTile(
title: Text(_selectedEvents[index].name),
onTap: () {
print("Voici l'id : ${_selectedEvents[index].idEvent} de l'evenement : ${_selectedEvents[index].name}");
},
),
);
}
);*/