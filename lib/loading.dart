import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'main.dart';

class loadingpg extends StatefulWidget {
  const loadingpg({Key key}) : super(key: key);

  @override
  _introductionState createState() => _introductionState();
}

class _introductionState extends State<loadingpg> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => myNavigationBar())) );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(

         child:  SpinKitCubeGrid(
            color: Colors.blue,
            size: 50.0,
          ),
      )

    );
  }
}
