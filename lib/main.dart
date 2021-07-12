import 'dart:async';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/Drive.dart';
import 'package:flutter_app/Home.dart';
import 'package:flutter_app/bluetoothconn.dart';
import 'package:flutter_app/loading.dart';
import 'package:flutter_app/reg_pg.dart';

import 'package:flutter_app/userPage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SaveImageDemo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> choosPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("surename");
    print(prefs.getString("surename"));
    if (prefs.getString("surename") == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => reg_pg()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => myNavigationBar()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5), () => choosPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(decoration: BoxDecoration(color: Colors.blueAccent)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(

                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.app_blocking_outlined,
                          color: Colors.lightBlue,
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        "Callex",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: Colors.redAccent,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text("Drive Safe",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class myNavigationBar extends StatefulWidget {
  @override

  _myNavigationBarState createState() => _myNavigationBarState();

}


class _myNavigationBarState extends State<myNavigationBar> {
  int currentIndex = 0;

  final List<Widget> _children = [userPage(), BluetoothApp()];

  void onTappedBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTappedBar,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_box),
              // ignore: deprecated_member_use
              title: new Text('User'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              // ignore: deprecated_member_use
              title: new Text('Home.dart'),
            ),
            // BottomNavigationBarItem(
            //   icon: new Icon(Icons.directions_car),
            //   // ignore: deprecated_member_use
            //   title: new Text('Drive'),
            // ),
          ]),
    );
  }
}
