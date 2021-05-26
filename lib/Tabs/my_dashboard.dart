import 'package:flutter/material.dart';
import 'package:us_together/Widgets/list_event.dart';

class DashboardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Ecran d'acceuil"),
      ),
      body: SafeArea (
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Mes évènements à venir",
                style: TextStyle(
                  fontFamily: "Pacifico"
                ),
              ),
              SizedBox(height: 10.0,),
              MyEventList(),
            ],
          )
      ),
    );
  }
}