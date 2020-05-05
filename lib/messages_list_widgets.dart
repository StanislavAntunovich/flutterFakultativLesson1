import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        message:
            "hello4 bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla 17",
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
  TextEditingController _textController = TextEditingController();
  ScrollController _scrollController = ScrollController(); //TODO scroll to last message

  List<Message> messagesList = [];

  @override
  void initState() {
    messagesList = _makeTestMessagesList();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.chatName,
            style: TextStyle(color: Colors.black38),
          ),
          backgroundColor: Colors.greenAccent,
        ),
        body: Column(
          children: <Widget>[_makeMessagesList(), _makeMessageInput()],
        ));
  }

  Widget _makeMessagesList() {
    return Flexible(
      child: ListView.builder(
          controller: _scrollController,
          itemCount: messagesList.length,
          padding: EdgeInsets.only(left: 8, right: 8),
          itemBuilder: (BuildContext context, int index) {
            var message = messagesList[index];
            return _makeBubble(message);
          }),
    );
  }

  Widget _makeMessageInput() {
    var textForm = TextFormField(
      decoration: InputDecoration(labelText: "сообщение"),
      controller: _textController,
    );
    var sendBtn = IconButton(icon: Icon(Icons.send), onPressed: _sendMessage);
    return Container(
      decoration: new BoxDecoration(
          border: new Border(top: new BorderSide(width: 0.5)),
          color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: textForm,
          ),
          sendBtn
        ],
      ),
    );
  }

  void _sendMessage() {
    var text = _textController.text;
    _textController.text = "";
    messagesList.add(new Message(
        message: text,
        author: "me",
        isOutgoing: true,
        creationTime: DateTime.now()));
    setState(() {});
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
        constraints: BoxConstraints(
            maxWidth: _calculateMaxWidth(context),
            minWidth: _calculateMinWidth(context)),
        child: messagesColumn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var color = _message.isOutgoing ? Colors.green : Colors.blue;
    var alignment =
        _message.isOutgoing ? Alignment.centerRight : Alignment.centerLeft;
    return Align(
        alignment: alignment,
        child: CustomPaint(
          painter:
              _BubblePainter(color: color, isOutgoing: _message.isOutgoing),
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
