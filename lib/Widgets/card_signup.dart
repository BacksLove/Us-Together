import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardFormSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
