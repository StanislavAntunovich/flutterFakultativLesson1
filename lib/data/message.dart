import 'package:flutter/widgets.dart';

class Message {
  String message;
  String author;
  DateTime creationTime;
  bool isOutgoing;

  Message({
    @required this.message,
    @required this.author,
    this.isOutgoing=false,
    this.creationTime
  }) {
    if (creationTime == null) {
      this.creationTime = DateTime.now();
    }
  }
}