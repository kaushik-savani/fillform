import 'package:fillform/viewpage.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(MaterialApp(
    home: viewpage(),
  ));
}

class form extends StatefulWidget {
  const form({Key? key}) : super(key: key);

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
