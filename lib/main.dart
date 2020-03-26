import 'package:flutter/material.dart';
import './home.dart';

void main() {
  runApp(FlesvoedingTimer());
}

class FlesvoedingTimer extends StatelessWidget {

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flesvoeding timer',
      home: Home(),
    );
  }
}
