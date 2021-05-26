import 'package:flutter/material.dart';


class InfoCard extends StatelessWidget {

  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard({@required this.text, @required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.pinkAccent,
              fontFamily: 'Source Sans Pro',
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
