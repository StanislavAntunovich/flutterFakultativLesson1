import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/messages_list_widgets.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget _makeRow(String chatName, String lastMessage) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
          return MessagesListWidget(chatName: chatName,);
        }));
      },
      child: Container(
        margin: EdgeInsets.all(9.0),
        padding: EdgeInsets.all(9.0),
        decoration: BoxDecoration(
            color: Colors.white10,
            border: Border.all(color: Colors.greenAccent)),
        child: Column(
          children: <Widget>[Text(chatName), Text(lastMessage)],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Наш Чат",
          style: TextStyle(color: Colors.black38),
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(9),
          children: <Widget>[
            _makeRow('Название чата1', 'Последнее сообщение'),
            _makeRow('Название чата2', 'Последнее сообщение'),
            _makeRow('Название чата3', 'Последнее сообщение'),
            _makeRow('Название чата4', 'Последнее сообщение'),
            _makeRow('Название чата5', 'Последнее сообщение'),
            _makeRow('Название чата6', 'Последнее сообщение'),
            _makeRow('Название чата7', 'Последнее сообщение'),
            _makeRow('Название чата8', 'Последнее сообщение'),
            _makeRow('Название чата9', 'Последнее сообщение'),
            _makeRow('Название чата10', 'Последнее сообщение'),
          ],
        ),
      ),
    );
  }
}
