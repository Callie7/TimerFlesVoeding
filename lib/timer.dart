import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings.dart';

class AnimatedTimer extends StatefulWidget {
  final Duration duration;
  _AnimatedTimerState state;

  AnimatedTimer(this.duration) {
    state = _AnimatedTimerState(duration);
  }

  void resetTimer() {
    state.resetTimer();
  }

  @override
  _AnimatedTimerState createState() => state;
}

class _AnimatedTimerState extends State<AnimatedTimer> {
  Duration _duration;
  Timer alertTimer;
  Timer counterTimer;
  DateTime _toTime;
  final DateFormat _dateFormat = DateFormat('HH:mm');
  DateTime _startTime;
  String _animationName = 'empty';
  SharedPreferences _prefs;

  _AnimatedTimerState(this._duration) {
    _startTime = DateTime.now();
    _toTime = _startTime.add(_duration);
  }

  @override
  void initState() {
    super.initState();
    loadData();
    counterTimer = Timer.periodic(Duration(seconds: 3), updateAnimation);
    alertTimer = Timer(_duration, startAlert);
  }

  void loadData() async {
    _prefs = await SharedPreferences.getInstance();
    loadStartTime();
  }

  void loadStartTime() {
    String startTime = _prefs.getString(Settings.keyNameStartTime);

    if (startTime == null) {
      _startTime = DateTime.now();
      Settings.setStartTime(_startTime);
    } else {
      setState(() {
        _startTime = DateTime.parse(startTime);
        _toTime = _startTime.add(_duration);
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
        switch (percentage) {
          case 10:
            _animationName = '0-10';
            break;
          case 20:
            _animationName = '10-20';
            break;
          case 30:
            _animationName = '20-30';
            break;
          case 40:
            _animationName = '30-40';
            break;
          case 50:
            _animationName = '40-50';
            break;
          case 60:
            _animationName = '50-60';
            break;
          case 70:
            _animationName = '60-70';
            break;
          case 80:
            _animationName = '70-80';
            break;
          case 90:
            _animationName = '80-90';
            break;
          case 100:
            _animationName = 'full';
            break;
          default:
        }
      });
    }
  }

  void startAlert() {
    print('tijd om voeding te geven');
  }

  void resetTimer() {
    _startTime = DateTime.now();
    Settings.setStartTime(_startTime);
    setState(() {
      _toTime = DateTime.now().add(_duration);
      _animationName = 'empty';
    });
    alertTimer.cancel();
    alertTimer = Timer(_duration, startAlert);
  }
}
