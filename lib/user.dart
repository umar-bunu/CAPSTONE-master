import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  File imageFile;

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openGallary(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _ShowChoiseDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Make your choise'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      _openGallary(context);
                    },
                    label: Text('Image'),

                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  FlatButton.icon(
                    icon: Icon(Icons.camera),
                    onPressed: () {
                      _openCamera(context);
                    },
                    label: Text('Camera'),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget nameval() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) return "name is not empty";
        return null;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.teal,
          ),
          labelText: "Name",
          helperText: "Name Cant Be Empty",
          hintText: "example"),
    );
  }

  Widget sureName() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) return "surename is not empty";
        return null;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.teal,
          ),
          labelText: "Surename",
          helperText: "Surename Cant Be Empty",
          hintText: "example"),
    );
  }
Widget emptyPic(){
  return Center(

    child: Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundColor: Colors.grey,
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: ()async {
              await      _ShowChoiseDialog(context);
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ],
    ),
  );

}
  Widget _decideImageView() {
    if (imageFile == null) {
      return Text('No Image Selected !!!');
    } else {
      return Center(

        child: Stack(
          children: <Widget>[
            CircleAvatar(
              radius: 80.0,
              backgroundImage: FileImage(imageFile),
            ),
            Positioned(
              bottom: 20.0,
              right: 20.0,
              child: InkWell(
                onTap: ()async {
                 await _decideImageView();
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.teal,
                  size: 28.0,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('User Page'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              emptyPic()
             ,_decideImageView(),
              nameval(),
              sureName(),
              RaisedButton(
                onPressed: () {
                  _ShowChoiseDialog(context);
                },
                child: Text('Select Image !'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
