import 'package:flutter/material.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:us_together/Backend/Entities/Event.dart';
import 'package:us_together/Backend/Implementations/EventProvider.dart';
import 'package:us_together/Backend/Implementations/SharedPreferences.dart';

class SyncEvents extends StatefulWidget {
  @override
  _SyncEventsState createState() => _SyncEventsState();
}

class _SyncEventsState extends State<SyncEvents> {
  List<Event> calendarEvent = [];
  List<Calendar> calendar = [];
  List<String> calendarNames = [];
  DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  EventProvider _eventProvider = EventProvider();
  bool _afficheDropdown = false;

  @override
  void initState() {
    _retrieveCalendar().then((value){
      print(calendarNames);
      _afficheDropdown = true;
    });
    super.initState();
  }

  Future<void> _retrieveCalendar () async {

    var permissionGranted = await _deviceCalendarPlugin.hasPermissions();
    if (permissionGranted.isSuccess && !permissionGranted.data) {
      permissionGranted = await _deviceCalendarPlugin.requestPermissions();
      if (!permissionGranted.isSuccess || !permissionGranted.data) {
        print("Probleme de permissions");
        return;
      }
    }
    setState(() {
      calendarNames.clear();
    });
    final calendarResult = await _deviceCalendarPlugin.retrieveCalendars();
    calendar = calendarResult.data;

    for (var calItem in calendar) {
      setState(() {
        calendarNames.add(calItem.name);
      });
    }
  }

  Future<void> _retrieveEvents(String idCal) async {

    var permissionGranted = await _deviceCalendarPlugin.hasPermissions();
    if (permissionGranted.isSuccess && !permissionGranted.data) {
      permissionGranted = await _deviceCalendarPlugin.requestPermissions();
      if (!permissionGranted.isSuccess || !permissionGranted.data) {
        print("Probleme de permissions");
        return;
      }
    }
    setState(() {
      calendarEvent.clear();
    });

    final calendarEventResult = await _deviceCalendarPlugin.retrieveEvents(idCal, RetrieveEventsParams(startDate: DateTime(2019, 06, 10),endDate: DateTime(2019, 12, 10)));
    var calEvent = calendarEventResult?.data;
    for (var ev in calEvent){
      setState(() {
        calendarEvent.add(ev);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Calendrier disponibles'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
          padding: EdgeInsets.all(15.0),
          child:
          (_afficheDropdown) ? ListView.builder(
            itemCount: calendarNames.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(calendarNames[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      print("${calendarNames[index]} est tapé et son id est : ${index}");
                      await _retrieveEvents((index+1).toString()).then((value){
                        showInfos((index));
                      });
                    },
                  ),
                ),
              );
            },
          ) : Text("Pas de liste a afficher")
      ),
    );
  }

  Future<void> showInfos(int index) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmation"),
            content: Text("Etes vous sur de vouloir synchroniser ce calendrier dans l'application. Les évènements ne seront visible que par vous dans un premier temps"),
            actions: <Widget>[
              FlatButton(
                child: const Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: const Text('Valider'),
                onPressed: () async {
                  setState(() {
                    calendarNames.removeAt(index);
                  });
                  for (var ev in calendarEvent) {
                    MyEvents currentEvent = MyEvents();
                    currentEvent.name = ev.title;
                    currentEvent.description = ev.description;
                    currentEvent.startDate = ev.start;
                    currentEvent.endDate = ev.end;
                    currentEvent.createdDate = DateTime.now();

                    await _eventProvider.AddEvent(currentEvent);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

}
