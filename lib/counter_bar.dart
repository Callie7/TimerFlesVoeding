import 'package:flutter/material.dart';
import './counter.dart';

class CounterBar extends StatelessWidget {
  final String _messageCounter = 'Aantal flesjes vandaag';
  final String _messageCounterYesterday = 'Aantal flesjes gisteren';

  int _counterYesterday;
  int _counter;

  CounterBar(this._counterYesterday, this._counter);

  @override
  Widget build(BuildContext context) {
    double width50 = MediaQuery.of(context).size.width*0.5;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width50,
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Counter(_messageCounterYesterday, _counterYesterday),
          ),
          Container(
            width: width50,
            padding: EdgeInsets.only(top: 10, right: 20),
            child:
                Counter(_messageCounter, _counter),
          ),
        ],
      ),
    );
  }
}
