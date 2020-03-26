import 'package:flutter/material.dart';

class ButtonWithDialog extends StatelessWidget {
  final Function confirmFunction;

  ButtonWithDialog(this.confirmFunction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          showAlertDialog(context);
        },
        child: Text('Bevestig voeding'),
        color: Colors.blue,
        textColor: Colors.white,
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Nee"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ja"),
      onPressed: () {
        confirmFunction();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Bevestig voeding"),
      content: Text(
          "Klopt het dat je de komende/afgelopen voeding wil bevestigen?"), //Make conditional based on the timer
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
