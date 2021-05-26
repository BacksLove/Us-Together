import 'dart:math';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:us_together/Backend/Entities/Event.dart';
import 'package:us_together/Backend/Entities/User.dart';
import 'package:us_together/Backend/Implementations/EventProvider.dart';
import 'package:us_together/Events/SyncEvents.dart';


class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController  _controller;
  EventProvider _eventProvider = EventProvider();
  DateTime _selectedDay;
  List myEvent = [];
  Map<DateTime, List> myEventFinal = {};
  List _selectedEvents = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _controller = CalendarController();

    theFunctions().then((value){
      print(myEventFinal.toString());
      setState(() {
        _selectedEvents = myEventFinal[_selectedDay] ?? [];
      });
    });

    super.initState();
  }

  Future<void> theFunctions() async {
    List sortedEvent = [];
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
    });
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = List.from(events);
      print(_selectedEvents);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Mon agenda"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TableCalendar(
                  locale: 'fr_FR',
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
                    todayColor: Colors.black,
                    selectedColor: Theme.of(context).accentColor,
                  ),
                  calendarController: _controller,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    centerHeaderTitle: true,
                  ),
                  events: myEventFinal,
                  onDaySelected: _onDaySelected,
                ),
                SizedBox(height: 10,),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SyncEvents())
                    );
                  },
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  child: Text("Synchroniser un calendrier"),
                ),
                SizedBox(),
                Container(
                  height: 200,
                  child: _buildEventList(),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((dataa) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(dataa.name),
          onTap: () => print('${dataa.name} tapped!'),
        ),
      ))
          .toList(),
    );
  }

}