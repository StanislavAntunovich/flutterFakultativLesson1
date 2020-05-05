import 'package:flutter/material.dart';
import 'package:flutterapp/data/message.dart';
import 'package:intl/intl.dart';

List<Message> _makeTestMessagesList() {
  var time = DateTime.now();
  return [
    new Message(
        message: "hello",
        author: "me",
        isOutgoing: true,
        creationTime: time.subtract(Duration(hours: 24))),
    new Message(
        message: "hello1",
        author: "John",
        isOutgoing: false,
        creationTime: time.subtract(Duration(hours: 23))),
    new Message(
        message: "hello2",
        author: "Jane",
        isOutgoing: false,
        creationTime: time.subtract(Duration(hours: 22))),
    new Message(
        message: "hello3",
        author: "John",
        isOutgoing: false,
        creationTime: time.subtract(Duration(hours: 21))),
    new Message(
        message: "hello4 bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla 17",
        author: "me",
        isOutgoing: true,
        creationTime: time.subtract(Duration(hours: 20))),
    new Message(
        message: "hello5",
        author: "me",
        isOutgoing: true,
        creationTime: time.subtract(Duration(hours: 19))),
    new Message(
        message: "hello6",
        author: "John",
        isOutgoing: false,
        creationTime: time.subtract(Duration(hours: 18))),
    new Message(
        message: "hello7",
        author: "me",
        isOutgoing: true,
        creationTime: time.subtract(Duration(hours: 17))),
    new Message(
        message: "hello7",
        author: "me",
        isOutgoing: true,
        creationTime: time.subtract(Duration(hours: 17))),
    new Message(
        message: "hello7",
        author: "me",
        isOutgoing: true,
        creationTime: time.subtract(Duration(hours: 17))),
    new Message(
        message: "hello7",
        author: "me",
        isOutgoing: true,
        creationTime: time.subtract(Duration(hours: 17))),
    new Message(
        message: "hello7",
        author: "me",
        isOutgoing: true,
        creationTime: time.subtract(Duration(hours: 17))),
  ];
}

class MessagesListWidget extends StatefulWidget {
  final String chatName;

  MessagesListWidget({@required this.chatName, Key key}) : super(key: key);

  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesListWidget> {
  @override
  Widget build(BuildContext context) {
    var messagesList = _makeTestMessagesList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.chatName,
          style: TextStyle(color: Colors.black38),
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView.builder(
          itemCount: messagesList.length,
          padding: EdgeInsets.only(left: 8, right: 8),
          itemBuilder: (BuildContext context, int index) {
            var message = messagesList[index];
            return _makeBubble(message);
          }),
    );
  }

  Widget _makeBubble(Message message) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: _MessageBubble(message),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Message _message;

  _MessageBubble(this._message);

  double _calculateMaxWidth(BuildContext context) {
    return MediaQuery.of(context).size.width / 3 * 2;
  }

  double _calculateMinWidth(BuildContext context) {
    return MediaQuery.of(context).size.width / 4;
  }

  Widget _makeMessageContent(BuildContext context) {
    String formattedDate = DateFormat('kk:mm').format(_message.creationTime);
    var messagesColumn = Column(
      children: <Widget>[
        Text(formattedDate),
        Text(_message.author),
        Text(_message.message)
      ],
    );

    return Padding(
      padding: EdgeInsets.all(6),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: _calculateMaxWidth(context), minWidth: _calculateMinWidth(context)),
        child: messagesColumn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var color = _message.isOutgoing ? Colors.green : Colors.blue;
    var alignment = _message.isOutgoing ? Alignment.centerRight : Alignment.centerLeft;
    return Align(
          alignment: alignment,
          child: CustomPaint(
            painter: _BubblePainter(color: color, isOutgoing: _message.isOutgoing),
            child: _makeMessageContent(context),
          ));
  }
}

class _BubblePainter extends CustomPainter {
  final Color color;
  final bool isOutgoing;

  _BubblePainter({
    @required this.color,
    this.isOutgoing,
  });

  var _radius = 10.0;
  var _x = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (isOutgoing) {
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            0,
            0,
            size.width - 8,
            size.height,
            bottomLeft: Radius.circular(_radius),
            topRight: Radius.circular(_radius),
            topLeft: Radius.circular(_radius),
          ),
          Paint()
            ..color = this.color
            ..style = PaintingStyle.fill);
      var path = new Path();
      path.moveTo(size.width - _x, size.height - 20);
      path.lineTo(size.width - _x, size.height);
      path.lineTo(size.width, size.height);
      canvas.clipPath(path);
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            size.width - _x,
            0.0,
            size.width,
            size.height,
            topRight: Radius.circular(_radius),
          ),
          Paint()
            ..color = this.color
            ..style = PaintingStyle.fill);
    } else {
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            _x,
            0,
            size.width,
            size.height,
            bottomRight: Radius.circular(_radius),
            topRight: Radius.circular(_radius),
            topLeft: Radius.circular(_radius),
          ),
          Paint()
            ..color = this.color
            ..style = PaintingStyle.fill);
      var path = new Path();
      path.moveTo(0, size.height);
      path.lineTo(_x, size.height);
      path.lineTo(_x, size.height - 20);
      canvas.clipPath(path);
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            0,
            0.0,
            _x,
            size.height,
            topRight: Radius.circular(_radius),
          ),
          Paint()
            ..color = this.color
            ..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
