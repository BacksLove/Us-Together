import 'package:flutter/material.dart';
import 'package:us_together/Authentification/login_view.dart';
import 'package:us_together/Backend/Entities/User.dart';
import 'package:us_together/Backend/Implementations/AuthProvider.dart';
import 'package:us_together/Backend/Implementations/SharedPreferences.dart';
import 'package:us_together/RootPage.dart';
import 'package:us_together/Users/ModifyUser.dart';
import 'package:us_together/Widgets/card_profile.dart';

class ProfilePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback signedOut;

  ProfilePage({this.auth, this.signedOut});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final SPreferences _preferences = SPreferences();
  User currentUser;

  void leaveApp () async {
    await widget.auth.logOut();
    widget.signedOut();
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    await _preferences.getCurrentUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon profil"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (currentUser != null) ? Text(currentUser.username,
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                ),
              ) : Container(),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.black,
                ),
              ),
              (currentUser != null) ? InfoCard(text: currentUser.firstname + " " + currentUser.lastname, icon: Icons.perm_identity) : Container(),
              (currentUser != null) ? InfoCard(text: currentUser.email, icon: Icons.email) : Container(),
              (currentUser != null) ? InfoCard(text: "Date de création : ${currentUser.createdDate.day}/${currentUser.createdDate.month}/${currentUser.createdDate.year}", icon: Icons.archive) : Container(),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: () {
                  leaveApp();
                },
                child: InfoCard(text: "Deconnexion", icon: Icons.exit_to_app),
              ),
            ],
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ModifyProfile(currentUser: currentUser,)));
          },
          icon: Icon(Icons.mode_edit),
          label: Text("Modifier le profil")
      ),
    );
  }
}