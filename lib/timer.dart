import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './preferences.dart';

class AnimatedTimer extends StatefulWidget {
  final Duration _duration;

  AnimatedTimer(this._duration);

  // void resetTimer() {
  //   state.resetTimer();
  // }

  @override
  _AnimatedTimerState createState() => _AnimatedTimerState();
}

class _AnimatedTimerState extends State<AnimatedTimer> {
  Timer alertTimer;
  Timer counterTimer;
  DateTime _toTime;
  final DateFormat _dateFormat = DateFormat('HH:mm');
  DateTime _startTime;
  String _animationName = 'empty';
  SharedPreferences _prefs;

  _AnimatedTimerState() {
    _startTime = DateTime.now();
    _toTime = _startTime.add(widget._duration);
  }

  @override
  void initState() {
    super.initState();
    loadData();
    counterTimer = Timer.periodic(Duration(seconds: 3), updateAnimation);
    alertTimer = Timer(widget._duration, startAlert);
  }

  void loadData() async {
    _prefs = await SharedPreferences.getInstance();
    loadStartTime();
  }

  void loadStartTime() {
    String startTime = _prefs.getString(Preferences.keyNameStartTime);

    if (startTime == null) {
      _startTime = DateTime.now();
      Preferences.setStartTime(_startTime);
    } else {
      setState(() {
        _startTime = DateTime.parse(startTime);
        _toTime = _startTime.add(widget._duration);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 8,
            child: Container(
              child: FlareActor(
                'assets/bottle.flr',
                fit: BoxFit.contain,
                animation: _animationName,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: <Widget>[
                Text(
                  'Tijdstip van de volgende voeding',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Text(
                  _dateFormat.format(_toTime),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateAnimation(Timer t) {
    int percentage = 100 -
        ((_toTime.difference(DateTime.now()).inSeconds /
                    _toTime.difference(_startTime).inSeconds) *
                100)
            .ceil();
    if (percentage <= 100) {
      setState(() {
        if(percentage >= 10 && percentage < 20)
          _animationName = '0-10';
        if(percentage >= 20 && percentage < 30)
          _animationName = '10-20';
        if(percentage >= 30 && percentage < 40)
          _animationName = '20-30';
        if(percentage >= 40 && percentage < 50)
          _animationName = '30-40';
        if(percentage >= 50 && percentage < 60)
          _animationName = '40-50';
        if(percentage >= 60 && percentage < 70)
          _animationName = '50-60';
        if(percentage >= 70 && percentage < 80)
          _animationName = '60-70';
        if(percentage >= 80 && percentage < 90)
          _animationName = '70-80';
        if(percentage >= 90 && percentage < 100)
          _animationName = '80-90';
        if(percentage == 100)
          _animationName = 'full';
      });
    }
  }

  void startAlert() {
    print('tijd om voeding te geven');
  }

  // void resetTimer() {
  //   _startTime = DateTime.now();
  //   Preferences.setStartTime(_startTime);
  //   setState(() {
  //     _toTime = DateTime.now().add(_duration);
  //     _animationName = 'empty';
  //   });
  //   alertTimer.cancel();
  //   alertTimer = Timer(_duration, startAlert);
  // }
}
