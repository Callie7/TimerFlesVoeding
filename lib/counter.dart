import 'package:flutter/material.dart';

class Counter extends StatelessWidget {

  final String _message;
  int _counter;

  Counter(this._message, this._counter);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _message,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          _counter.toString(),
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  void increaseCounter() {
    _counter++;
  }
}