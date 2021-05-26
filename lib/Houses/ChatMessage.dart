import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:us_together/Backend/Entities/Messages.dart';
import 'package:us_together/Backend/Implementations/MessageProvider.dart';
import 'package:us_together/Backend/Implementations/SharedPreferences.dart';
import 'package:bubble/bubble.dart';

class ChatMessage extends StatefulWidget {
  String idHouse;

  ChatMessage(this.idHouse);

  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  String idUser = "";
  String username = "";
  SPreferences _preferences = SPreferences();
  TextEditingController messageController;

  @override
  void initState() {
    messageController = TextEditingController(text: "");
    _preferences.getString("currentUserEmail").then((value){
      setState(() {
        idUser = value;
      });
    });
    _preferences.getString("currentUserUsername").then((value){
      setState(() {
        username = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: MessageProvider().getAllMessages(widget.idHouse),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text(
                      "Vous n'avez aucun foyer, rejoignez en un vite !");
                  return new ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      reverse: true,
                      itemBuilder: (BuildContext context, int index) => buildMessage(context, snapshot.data.documents[index])
                  );
                }
              )
            ),
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                filled: true,
                hintText: "Ecrivez votre texte ici",
                focusColor: Theme.of(context).accentColor,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                ),
                suffixIcon: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    if (messageController.text != "") {
                      Messages mes = Messages();
                      mes.idUser = idUser;
                      mes.idHouse = widget.idHouse;
                      mes.username = username;
                      mes.message = messageController.text;
                      mes.createdDate = DateTime.now();

                      MessageProvider().addMessage(mes).then((value){
                        if (!value) {
                          print("Message non envoyé");
                        } else {
                          setState(() {
                            messageController = TextEditingController(text: "");
                          });
                        }
                      });
                    } else {
                      print("Entrez du text");
                    }
                  },
                  icon: Icon(Icons.send),
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMessage (BuildContext context, DocumentSnapshot snapshot) {
    Messages messages = Messages();
    messages.fromDocumentSnapshot(snapshot);
    return Column(
      children: <Widget>[
        (messages.idUser == idUser) ?
        Bubble(
          nip: BubbleNip.rightBottom,
          elevation: 3,
          alignment: Alignment.bottomRight,
          color: Theme.of(context).accentColor,
          child: Column(
            children: <Widget>[
              Text(
                messages.username,
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 3,),
              Text(
                messages.message,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ],
          ),
        ) :
        Bubble(
          nip: BubbleNip.leftBottom,
          elevation: 3,
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                messages.username,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 3,),
              Text(messages.message),
            ],
          ),
        ),
        SizedBox(height: 15,)
      ],
    );
  }
}
