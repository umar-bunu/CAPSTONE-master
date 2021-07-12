import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/reg_pg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Utility.dart';

class userPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<userPage> {
  // File imageFile;
  String name1 = "name";
  Future<File>  imageFile1;
  Image imageFromPreferences;
  String surename1 = "surename";

  loadImageFromPreferences() {
    Utility.getImageFromPreferences().then((img) {
      if (null == img) {
        return;
      }

      setState(() {
        imageFromGallery();
        imageFromPreferences = Utility.imageFromBase64String(img);
      });
    });
  }

  imageFromGallery() {
    return FutureBuilder<File>(
      future: imageFile1,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          //print(snapshot.data.path);
          Utility.saveImageToPreferences(
              Utility.base64String(snapshot.data.readAsBytesSync()));
          return  const Text(
            '',
            textAlign: TextAlign.center,
          );
        } else if (null != snapshot.error) {
          return const Text(
            '',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            '',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
  _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();



    setState(() {
      print("seted state");
      name1 = prefs.getString("user_name");
      surename1 = prefs.getString("surename");
    });
  }

//   void loading() async {
//     print("this is the  name from _UserPageState");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     await setState(() {
//       name = prefs.getString("user_name") as Future<String>;
//       surename = prefs.getString("surename") as Future<String>;
//
//       print("this is the sure name from _UserPageState:$surename");
//
//       print("datat fetch");
//     });
//
// // return await prefs.getString("user_name") ;
//   }

  @override
  void initState() {
    super.initState();
    _load();
    loadImageFromPreferences();
    print("init state ");
  }

  void logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
    print(" this is the logout function!!!!!!!!!!!!!!!!!!!!!!!");

    exit(0);
  }

  Future<void> showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
        child: Text("Cancel"), onPressed: () => Navigator.pop(context, true)
        //   builder: (BuildContext context) => myNavigationBar()));
        );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        logout();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Would you like to continue using the application"),
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

  Widget getNameSureName() {}

  Widget emptyPic() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 100.0,
            backgroundImage: AssetImage('assets/image.png'),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () async {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.mode_edit),
              onPressed: () async {
                //logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) => reg_pg()));
              }),
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                //logout();
                await showAlertDialog(context);
              })

        ],
        title: Text('User Page'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // emptyPic(),
              imageFromGallery(),

              null == imageFromPreferences ?

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: new BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child:Icon(Icons.person,color: Colors.white70,size: 200,) ,
                  ),


                ],
              )  :

              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: new BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child:imageFromPreferences ,
                  ),


                ],
              ) ,
              Container(
                  child: Card(
                      color: Colors.white,
                      margin:
                          EdgeInsets.symmetric(vertical: 100, horizontal: 25.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.dynamic_feed,
                          color: Colors.blue[900],
                        ),
                        title: Text(
                       "$name1 $surename1",
                          style: TextStyle(
                              fontFamily: 'TimesNewRoman', fontSize: 35.0),
                        ),
                      ))

                  // FutureBuilder<String>(
                  //     future: name,
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         String n=snapshot.data;
                  //         return Card(
                  //             color: Colors.white,
                  //             margin:
                  //             EdgeInsets.symmetric(vertical:100, horizontal: 25.0),
                  //             child: ListTile(
                  //               leading: Icon(
                  //                 Icons.dynamic_feed,
                  //                 color: Colors.blue[900],
                  //               ),
                  //
                  //               title: Text(
                  //                 n ,
                  //                 style:
                  //                 TextStyle(fontFamily: 'TimesNewRoman', fontSize: 35.0),
                  //               ),
                  //             ));
                  //       }
                  //       else if (snapshot.hasError) {
                  //         return Text("error ${snapshot.error}");
                  //       }
                  //       return Center(
                  //           child:CircularProgressIndicator()
                  //       );
                  //     }
                  // ),

                  ),

              // FutureBuilder<String>(
              //   future: name, // a previously-obtained Future<String> or null
              //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              //
              //     if (snapshot.hasData) {
              //       String n=snapshot.data;
              //       return Card(
              //           color: Colors.white,
              //           margin:
              //           EdgeInsets.symmetric(vertical:100, horizontal: 25.0),
              //           child: ListTile(
              //             leading: Icon(
              //               Icons.dynamic_feed,
              //               color: Colors.blue[900],
              //             ),
              //
              //             title: Text(
              //               n ,
              //               style:
              //               TextStyle(fontFamily: 'TimesNewRoman', fontSize: 35.0),
              //             ),
              //           ));
              //     } else if (snapshot.hasError) {
              //     return  Text(
              //         "errr"  ,
              //         style:
              //         TextStyle(fontFamily: 'TimesNewRoman', fontSize: 35.0),
              //       );
              //
              //     } else {
              //
              //       return  Text(
              //         "loading"  ,
              //         style:
              //         TextStyle(fontFamily: 'TimesNewRoman', fontSize: 35.0),
              //       );
              //
              //     }
              //
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
