import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/Custom_buttom.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static String idregister = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  bool isloading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kprimarycolor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Spacer(
                  flex: 2,
                ),
                Image.asset('assets/images/scholar.png'),
                const Text(
                  "scholar chat",
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'Pacifico'),
                ),
                Spacer(flex: 1),
                Row(
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  onChange: (data) {
                    email = data;
                  },
                  hinttext: 'Email',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  obscuretext: true,
                  onChange: (data) {
                    password = data;
                  },
                  hinttext: 'Password',
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButtom(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        isloading = true;
                      });
                      try {
                        await Use_registiration();
                        Toast_method('success');
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak password') {
                          Toast_method('weak password');
                        } else if (ex.code == 'email-already-in-use') {
                          Toast_method('email is already in use');
                        }
                      }
                      await Future.delayed(Duration(seconds: 1));

                      isloading = false;
                      setState(() {});
                    }
                  },
                  textreq: 'Register',
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "already have an account",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '  Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void Toast_method(String message) {
    Fluttertoast.showToast(
        msg: (message),
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green);
  }

  Future<void> Use_registiration() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
