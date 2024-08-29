import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class chat_screen extends StatefulWidget {
  static String id = 'chatscreen';

  @override
  State<chat_screen> createState() => _chat_screenState();
}

class _chat_screenState extends State<chat_screen> {
  TextEditingController controller = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final controllerview = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kmessagescollection);

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy("CreatedAt", descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kprimarycolor,
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(height: 50, kologo),
                    Text(
                      'chat App',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              body: Column(children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: controllerview,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        if (messagesList[index].id == email) {
                          return chatBubble(
                            messages: messagesList[index],
                          );
                        } else {
                          return chatBubblefriend(
                              messages: messagesList[index]);
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add(
                        {
                          'message': data,
                          'CreatedAt': DateTime.now(),
                          'id': email
                        },
                      );
                      controller.clear();
                      controllerview.animateTo(
                        0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: "send message",
                      suffix: Icon(Icons.send, color: kprimarycolor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: kprimarycolor),
                      ),
                    ),
                  ),
                )
              ]),
            );
          } else {
            return Text('Loading....');
          }
        });
  }
}
