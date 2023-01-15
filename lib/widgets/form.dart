import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;

  const CustomForm({
    Key? key,
    required this.hintText,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    contentPadding: EdgeInsets.all(12)),
              );
  }
}