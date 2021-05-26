import 'package:flutter/material.dart';
import 'package:us_together/Backend/Entities/House.dart';
import 'package:us_together/Houses/CalendarHouse.dart';
import 'package:us_together/Houses/ChatMessage.dart';
import 'package:us_together/Houses/ListMember.dart';


class HouseDetail extends StatefulWidget {
  final House currentHouse;

  HouseDetail(this.currentHouse);

  @override
  _HouseDetailState createState() => _HouseDetailState();
}

class _HouseDetailState extends State<HouseDetail> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Foyer : ${widget.currentHouse.name}"),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.info_outline),
            onPressed: () {
              showInfos();
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          unselectedLabelColor: Colors.white,
          labelColor: Theme.of(context).accentColor,
          tabs: <Widget>[
            new Tab(
              icon: new Icon(Icons.people),
            ),
            new Tab(
              icon: new Icon(Icons.schedule),
            ),
            new Tab(
              icon: new Icon(Icons.message),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListMember(widget.currentHouse.users),
          CalendarHouse(widget.currentHouse.idHouse),
          ChatMessage(widget.currentHouse.idHouse),
        ],
      ),
    );
  }

  Future<void> showInfos() {
    return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Description"),
        content: Text(widget.currentHouse.description),
        actions: <Widget>[
          FlatButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }
}
