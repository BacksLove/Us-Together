import 'package:flutter/material.dart';
import 'package:us_together/Authentification/login_view.dart';
import 'package:us_together/Backend/Implementations/AuthProvider.dart';
import 'package:us_together/home.dart';

// Page Root qui s'occupe de la redirection et du statut de l'utilisateur

class RootPage extends StatefulWidget {
  RootPage({this.auth,this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    widget.auth.currentUser().then( (userId) {
      setState(() {
        _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
    super.initState();
  }

  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  // Fonction de redirection en fonction du statut

  @override
  Widget build(BuildContext context) {
    switch(_authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginView(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return new Home(
          auth: widget.auth,
          signedOut: _signedOut,
        );
    }

  }
}
