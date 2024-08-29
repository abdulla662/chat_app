import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class chatBubble extends StatelessWidget {
  const chatBubble({super.key, required this.messages});
  final Message? messages;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 150,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: kprimarycolor,
        ),
        child: Text(
          messages!.msg,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class chatBubblefriend extends StatelessWidget {
  const chatBubblefriend({super.key, required this.messages});
  final Message? messages;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 150,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Color(0xff006D84),
        ),
        child: Text(
          messages!.msg,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
