import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './counter_bar.dart';
import './confirm_button.dart';
import './timer.dart';
import './preferences.dart';
import 'settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;
  int _counterYesterday = 0;
  SharedPreferences _prefs;

  Duration _duration = Duration(hours: 3);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    _prefs = await SharedPreferences.getInstance();
    loadCounterValues();
    loadDuration();
  }

  void loadCounterValues() async {
    int counter = _prefs.getInt(Preferences.keyNameCounterToday) ?? 0;
    int counterYesterday =
        _prefs.getInt(Preferences.keyNameCounterYesterday) ?? 0;
    String counterDate = _prefs.getString(Preferences.keyNameCounterDate);

    if (counterDate == null) {
      Preferences.setCounterDate(DateTime.now());
      counterYesterday = 0;
      counter = 0;
      Preferences.setCounters(counter, counterYesterday);
    } else {
      final DateFormat dateFormat = DateFormat('yyyyMMdd');
      final int differenceInDays =
          int.parse(dateFormat.format(DateTime.now())) -
              int.parse(dateFormat.format(DateTime.parse(counterDate)));
      if (differenceInDays == 1) {
        //Set counter yesterday with the latest value of counterToday
        counterYesterday = counter;
        counter = 0;
        Preferences.setCounters(counter, counterYesterday);
      } else if (differenceInDays > 1) {
        counterYesterday = 0;
        counter = 0;
        Preferences.setCounters(counter, counterYesterday);
      }
      Preferences.setCounterDate(DateTime.now());
    }
    setState(() {
      _counter = counter;
      _counterYesterday = counterYesterday;
    });
  }

  void loadDuration() async {
    int periodH = _prefs.getInt(Preferences.keyNamePeriodH) ?? 3;
    int periodM = _prefs.getInt(Preferences.keyNamePeriodM) ?? 0;
    print('hours: "$periodH"');
    print('minutes: "$periodM"');

    setState(() {
      _duration = Duration(hours: periodH, minutes: periodM);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
              setState(() {
                loadDuration();
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: CounterBar(_counterYesterday, _counter),
              ), // Counters
              Flexible(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: AnimatedTimer(_duration),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: ButtonWithDialog(confirmed),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void confirmed() {
    increaseCounter();
  }

  void increaseCounter() {
    setState(() {
      _counter++;
    });
    Preferences.setCounterToday(_counter);
  }
}
