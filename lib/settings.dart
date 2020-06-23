import 'package:flesvoeding_timer/settings/duration.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  final List<Widget> settingEntries = <Widget>[
    DurationSetting(),
  ];


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Instellingen"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: settingEntries.length,
              itemBuilder: (BuildContext context, int index) {
                return settingEntries[index];
              }),
        ),
      ),
    );
  }
}
