import 'package:flutter/material.dart';
import 'package:us_together/Backend/Implementations/UserProvider.dart';
import 'package:us_together/Backend/Entities/User.dart';

class ListMember extends StatefulWidget {
  final List<String> _list;

  ListMember(this._list);

  @override
  _ListMemberState createState() => _ListMemberState();
}

class _ListMemberState extends State<ListMember> {

  List<User> users = [];

  @override
  void initState() {
    UserProvider().getAllUserByList(widget._list).then( (value) {
      setState(() {
        users = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            User user = users[index];
            return Card(
              child: ListTile(
                leading: new Icon(Icons.perm_identity),
                title: Text(user.username),
                subtitle: Text("${user.firstname} ${user.lastname}"),
              ),
            );
          },
        ),
      )
    );
  }
}
