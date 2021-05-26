import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:us_together/Authentification/login_view.dart';
import 'package:us_together/Backend/Entities/User.dart';
import 'package:us_together/Backend/Implementations/AuthProvider.dart';
import 'package:us_together/RootPage.dart';

class SignUpView extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  SignUpView({this.auth, this.onSignedIn});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

// Vue de l'inscription utilisateur

class _SignUpViewState extends State<SignUpView> {
  TextEditingController _firstnameController;
  TextEditingController _lastnameController;
  TextEditingController _emailController;
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  // Fonction de vérification des champs du formulaire

  bool checkFields() {
    if (_lastnameController.text.isEmpty || _firstnameController.text.isEmpty || _usernameController.text.isEmpty ||
        _emailController.text.isEmpty || _passwordController.text.isEmpty)
      return false;
    return true;
  }

  // Initialisation des champs du formulaire

  @override
  void initState() {
    _firstnameController = TextEditingController(text: "");
    _lastnameController = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _usernameController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil.getInstance().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomPadding: true,
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
            Column(
            crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Image.asset(
                    "assets/images/family2.png",
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil.getInstance().setWidth(200),
                    ),
                    Container(
                      width: double.infinity,
                      height: ScreenUtil.getInstance().setHeight(800),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 15.0),
                                blurRadius: 15.0
                            ),
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, -10.0),
                                blurRadius: 10.0
                            ),
                          ]),
                      child: Padding(
                        padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(35),
                            ),
                            Text("Nom",
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26),
                                  fontFamily: 'Source Sans Pro'),),
                            TextFormField(
                              controller: _lastnameController,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Prénom",
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26),
                                  fontFamily: 'Source Sans Pro'),),
                            TextFormField(
                              controller: _firstnameController,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Pseudo",
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26),
                                  fontFamily: 'Source Sans Pro'),),
                            TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Email",
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26),
                                  fontFamily: 'Source Sans Pro'),),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Mot de passe",
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26),
                                  fontFamily: 'Source Sans Pro'),),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(130.0),
                        ),
                        InkWell(
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(330),
                            height: ScreenUtil.getInstance().setHeight(75),
                            decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.pinkAccent.withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  if (!checkFields())
                                    return;
                                  User cuser = new User();
                                  cuser.lastname = _lastnameController.text;
                                  cuser.firstname = _firstnameController.text;
                                  cuser.email = _emailController.text;
                                  cuser.username = _usernameController.text;
                                  cuser.createdDate = DateTime.now();
                                  cuser.updatedDate = DateTime.now();
                                  await AuthProvider().signUpWithEmail(cuser, _passwordController.text).then((value){
                                    if (value) {
                                      widget.onSignedIn();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => RootPage(auth: widget.auth, onSignedIn: widget.onSignedIn,)));
                                    } else {
                                      print("Error pendant l'inscription");
                                    }
                                  });
                                },
                                child: Center(
                                  child: Text("Inscription",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Source Sans Pro",
                                          fontSize: 18,
                                          letterSpacing: 1.0)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(80),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Déja un compte ? ",
                          style: TextStyle(fontFamily: "Source Sans Pro"),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginView())
                            );
                          },
                          child: Text("Connexion",
                              style: TextStyle(
                                  color: Colors.pinkAccent,
                                  fontFamily: "Source Sans Pro"
                              )
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],)
        )
      );
    }
}
