import 'package:flutter/material.dart';
import 'package:us_together/Backend/Implementations/AuthProvider.dart';
import 'Tabs/my_dashboard.dart';
import 'Tabs/my_agenda.dart';
import 'Tabs/my_houses.dart';
import 'Tabs/my_profile.dart';


class Home extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback signedOut;

  Home({this.auth, this.signedOut});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> _children = [];

  @override
  void initState() {
    setState(() {
      _children = [
        DashboardPage(),
        HousesPage(),
        CalendarPage(),
        ProfilePage(auth: widget.auth, signedOut: widget.signedOut,)
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: new Icon(Icons.dashboard),
              title: new Text("Accueil"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: new Icon(Icons.home),
              title: new Text("Foyers"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: new Icon(Icons.calendar_today),
              title: new Text("Agenda"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: new Icon(Icons.account_box),
              title: new Text("Profil"),
            ),
          ]
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}