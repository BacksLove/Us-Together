import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardForm extends StatefulWidget {
  @override
  _CardForm createState() => _CardForm();

}

class _CardForm extends State<CardForm> {

  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

  TextEditingController get passwordController => _passwordController;

  set passwordController(TextEditingController value) {
    _passwordController = value;
  }

  TextEditingController get emailController => _emailController;

  set emailController(TextEditingController value) {
    _emailController = value;
  }
}
