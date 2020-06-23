import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {

  String _message;

  TestWidget(this._message);

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget._message),
    );
  }
}