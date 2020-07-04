import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  CustomTextField(this.controller, this.hintText);
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15, top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFFF1E6FF),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          minLines: 3,
          maxLines: 4,
          controller: widget.controller,
          cursorColor: Colors.black,
          decoration: new InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: widget.hintText),
        ),
      ),
    );
  }
}
