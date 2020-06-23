import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../preferences.dart';

class DurationSetting extends StatefulWidget {
  @override
  _DurationSettingState createState() => _DurationSettingState();
}

class _DurationSettingState extends State<DurationSetting> {
  SharedPreferences _prefs;
  int _periodH = 3;
  int _periodM = 0;

  @override
  void initState() {
    loadDuration();
    super.initState();
  }

  void loadDuration() async {
    _prefs = await SharedPreferences.getInstance();

    setState(() {
      _periodH = _prefs.getInt(Preferences.keyNamePeriodH) ?? 3;
      _periodM = _prefs.getInt(Preferences.keyNamePeriodM) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(flex: 6, child: Text("Tijd tussen 2 voedingen")),
          Expanded(
            flex: 2,
            child: TextField(
              controller: TextEditingController()..text = _periodH.toString(),
              onSubmitted: (String value) {
                _periodH = int.parse(value);
                Preferences.setPeriod(_periodH, _periodM);
              },
              decoration: new InputDecoration(labelText: "Uren"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: TextField(
              controller: TextEditingController()..text = _periodM.toString(),
              onSubmitted: (String value) {
                _periodM = int.parse(value);
                print(_periodM);
                Preferences.setPeriod(_periodH, _periodM);
              },
              decoration: new InputDecoration(labelText: "Minuten"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
            ),
          ),
        ],
      ),
    );
  }
}
