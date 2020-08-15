import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String title;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const TextInput({
    Key key,
    this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.keyboardType,
    this.controller,
  }) : super(key: key);

  @override
  _TextInputState createState() {
    return _TextInputState(
      title: title,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
    );
  }
}

class _TextInputState extends State<TextInput> {
  final String title;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;

  _TextInputState({
    this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.keyboardType,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Required';
        }
        return null;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          labelText: title,
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          prefixIcon: prefixIcon,
          suffix: suffixIcon),
      obscureText: obscureText ?? false,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      controller: controller,
      keyboardType: keyboardType,
    );
  }
}
