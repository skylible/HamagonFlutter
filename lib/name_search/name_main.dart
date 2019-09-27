import 'package:flutter/material.dart';

class NameMain extends StatefulWidget {
  @override
  _NameMainState createState() => _NameMainState();
}

class _NameMainState extends State<NameMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: InputDecorator(
        child: TextField(),
      ),
    ));
  }
}
