import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/Custom_buttom.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class loginpage extends StatefulWidget {
  loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  String? email;

  String? password;

  bool isloading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Form(
        key: formkey,
        child: Scaffold(
          backgroundColor: kprimarycolor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
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
                      "Login",
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
                        await User_login();
                        Navigator.pushNamed(context, 'chatscreen',
                            arguments: email);
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
                  textreq: 'login',
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "don't have an account ?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.idregister);
                      },
                      child: Text(
                        '  Register',
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

  Future<void> User_login() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  void Toast_method(String message) {
    Fluttertoast.showToast(
        msg: (message),
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green);
  }
}
