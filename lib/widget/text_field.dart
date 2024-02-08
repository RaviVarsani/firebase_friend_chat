import 'package:flutter/material.dart';

class textInputField extends StatelessWidget {
  textInputField({
    Key? key,
    this.icon,
    this.controllers,
    this.keyboardType,
    required this.readOnly,
  });

  final icon;
  final controllers;
  final keyboardType;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllers,
      readOnly: readOnly,
      enabled: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(icon)),
    );
  }
}
