import 'package:chat_app/constants.dart';

class Message {
  final String msg;
  final String id;

  Message(this.msg, this.id);
  factory Message.fromJson(Jsondata) {
    return Message(Jsondata[kmessage], Jsondata['id']);
  }
}
