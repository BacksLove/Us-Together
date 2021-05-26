import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:us_together/Backend/Entities/House.dart';
import 'package:us_together/Backend/Entities/User.dart';
import 'package:us_together/Backend/Implementations/HouseProvider.dart';
import 'package:us_together/Backend/Implementations/SharedPreferences.dart';

class InvitePeople extends StatefulWidget {
  String idHouse;

  InvitePeople({this.idHouse});
  @override
  _InvitePeopleState createState() => _InvitePeopleState();
}

class _InvitePeopleState extends State<InvitePeople> {
  User currentUser = User();
  House currentHouse = House();
  List<String> inviteList = [];
  TextEditingController inviteController;
  SPreferences _preferences = SPreferences();
  HouseProvider _houseProvider = HouseProvider();

  @override
  void initState() {
    inviteController = TextEditingController(text: "");
    _preferences.getCurrentUser().then( (value) {
      setState(() {
        currentUser = value;
        print(currentUser.toMap());
      });
    });
    _houseProvider.GetHouseWithId(widget.idHouse).then((value){
      setState(() {
        currentHouse = value;
        print(currentHouse.name + " " + currentHouse.code);
      });
    });
    super.initState();
  }

   void inviteAll() async {
    if (inviteList.length < 1) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Ajoutez au moins une adresse mail"),));
      return;
    } else {
      for (var mailToInvite in inviteList) {
        final Email email = Email(
          body: "Salut c'est ${currentUser.username},"
              "Je viens de creer le foyer ${currentHouse.name} que tu peux rejoindre grace au code : ${currentHouse.code} !"
              "N'attends plus et viens vite nous rejoindre",
          subject: '[Us Together] - Rejoins vite mon foyer!',
          recipients: ['$mailToInvite']
        );
        await FlutterEmailSender.send(email);
      }
    }

    /*
    Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HousesPage() ),
              null);
        },
     */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Personnes à inviter'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 30),
        child: Column(
          children: <Widget>[
            TextField(
              controller: inviteController,
              decoration: InputDecoration(
                  labelText: 'email',
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
                  suffixIcon: IconButton(
                    icon : Icon(Icons.send),
                    color: Colors.white,
                    onPressed: () {
                      if (inviteController.text != "") {
                        setState(() {
                          inviteList.add(inviteController.text);
                          inviteController = TextEditingController(text: "");
                        });
                      } else {
                        print("Entrez un texte");
                      }
                    },
                  )
              ),
            ),
            SizedBox(height: 20,),
            (inviteList.length == 0) ? Text("Ajoutez les emails des personnes à inviter") :
            Container(
              child: Expanded(
                child: ListView.builder(
                    itemCount: inviteList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        //background: Container(color: Colors.red),
                        key: Key(inviteList[index]),
                        onDismissed: (direction) {
                          Scaffold
                              .of(context)
                              .showSnackBar(SnackBar(content: Text("${inviteList[index]} supprimé")));
                          setState(() {
                            inviteList.removeAt(index);
                          });
                        },
                        child: Card(
                          elevation: 4,
                          child: ListTile(
                            leading: Icon(Icons.person_outline),
                            title: Text(inviteList[index]),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          inviteAll();
        },
        label: Text("Envoyer"),
        icon: Icon(Icons.email),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
