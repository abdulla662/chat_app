import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {required this.hinttext, this.onChange, this.obscuretext = false});
  String? hinttext;
  Function(String)? onChange;
  bool? obscuretext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscuretext!,
      style: TextStyle(color: Colors.white),
      validator: (data) {
        if (data!.isEmpty) {
          return "field is required ";
        }
      },
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(color: Colors.white),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
