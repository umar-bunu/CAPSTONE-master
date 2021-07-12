import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class bluetoothconn extends StatefulWidget {
  const bluetoothconn({key}) : super(key: key);

  @override
  _bluetoothconnState createState() => _bluetoothconnState();
}

class _bluetoothconnState extends State<bluetoothconn> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: new AppBar(
        title: new Text('Drive Mode'),
      ),

    ));
  }
}
