import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:us_together/Backend/Implementations/AuthProvider.dart';
import 'package:us_together/Authentification/signup_view.dart';
import 'package:us_together/RootPage.dart';
import 'package:us_together/home.dart';


class LoginView extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  LoginView({this.auth, this.onSignedIn});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  TextEditingController _emailController;
  TextEditingController _passwordController;


  @override
  void initState() {
    _emailController = TextEditingController(text: "");
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
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 130.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil.getInstance().setWidth(160),
                    ),
                    Container(
                      width: double.infinity,
                      height: ScreenUtil.getInstance().setHeight(500),
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
                            Text("Us Together",
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(45),
                                  fontFamily: 'Pacifico',
                                  letterSpacing: .6),),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Email",
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26),
                                  fontFamily: 'Source Sans Pro'),),
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "email",
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
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "mot de passe",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(35),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text("Mot de passe oublié",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Source Sans Pro",
                                      fontSize: ScreenUtil.getInstance().setSp(28)
                                  ),
                                ),
                              ],
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
                                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty){
                                    return;
                                  }
                                  bool result = await widget.auth.signInWithEmail(_emailController.text, _passwordController.text);
                                  if (result) {
                                    widget.onSignedIn();
                                  } else {
                                    setState(() {
                                      _emailController = TextEditingController(text: "");
                                      _passwordController = TextEditingController(text: "");
                                    });
                                    print("Infos incorrectes");
                                    //initState();
                                  }
                                },
                                child: Center(
                                  child: Text("Connexion",
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
                      height: ScreenUtil.getInstance().setHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        horizontalLine(),
                        Text("Connexion via réseaux sociaux",
                            style: TextStyle(
                                fontSize: 12.0, fontFamily: "Source Sans Pro")),
                        horizontalLine()
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            await widget.auth.loginWithGoogle().then((result) {
                              if (!result){
                                print("Echec de la connexion avec Google");
                                return;
                              } else {
                                widget.onSignedIn();
                              }
                            });
                          },
                          child: Image.asset(
                            "assets/images/google_logo.png",
                            height: 50,
                            width: 200,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Nouvel utilisateur ? ",
                          style: TextStyle(fontFamily: "Source Sans Pro"),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpView(auth: widget.auth, onSignedIn: widget.onSignedIn))
                            );
                          },
                          child: Text("S'inscrire",
                              style: TextStyle(
                                  color: Colors.pinkAccent,
                                  fontFamily: "Source Sans Pro")),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
