import 'dart:math';

import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Chat_app());
}

class Chat_app extends StatelessWidget {
  const Chat_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'loginpage': (context) => loginpage(),
          RegisterScreen.idregister: (context) => RegisterScreen(),
          chat_screen.id: (context) => chat_screen()
        },
        initialRoute: 'loginpage');
  }
}
