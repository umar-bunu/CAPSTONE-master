import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Utility.dart';

class SaveImageDemo extends StatefulWidget {
  SaveImageDemo() : super();

  final String title = "Flutter Save Image in Preferences";

  @override
  _SaveImageDemoState createState() => _SaveImageDemoState();
}

class _SaveImageDemoState extends State<SaveImageDemo> {
  //
  Future<File> imageFile1;
  Image imageFromPreferences;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile1 = ImagePicker.pickImage(source: source);
    });
  }

  loadImageFromPreferences() {
          Utility.getImageFromPreferences().then((img) {
            if (null == img) {
              return;
            }
            setState(() {
              imageFromPreferences = Utility.imageFromBase64String(img);
      });
    });
  }

  Widget imageFromGallery() {
    return FutureBuilder<File>(
      future: imageFile1,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          //print(snapshot.data.path);
          Utility.saveImageToPreferences(
              Utility.base64String(snapshot.data.readAsBytesSync()));
          return Center(
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 80.0,



                  backgroundImage: FileImage(snapshot.data),
                ),
                Positioned(
                  bottom: 20.0,
                  right: 20.0,
                  child: InkWell(
                    onTap: () async {
                      // _decideImageView();

                    },
                    child: IconButton(icon:Icon(Icons.camera_alt,
                      color: Colors.teal,
                      size: 28.0,) ,onPressed: (){
                      pickImageFromGallery(ImageSource.gallery);
                      setState(() {
                        imageFromPreferences = null;
                      });
                    },

                    ),
                  ),
                ),
              ],
            ),
          ); Image.file(
            snapshot.data,
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Select',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImageFromPreferences();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              pickImageFromGallery(ImageSource.gallery);
              setState(() {
                imageFromPreferences = null;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              loadImageFromPreferences();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            // imageFromGallery(),
            SizedBox(
              height: 20.0,
            ),
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
                  child:Icon(Icons.person,color: Colors.grey,size: 150,) ,
                ),

                IconButton(icon:Icon(Icons.camera_alt,
                  color: Colors.teal,
                  size: 28.0,) ,onPressed: (){

                  pickImageFromGallery(ImageSource.gallery);
                  setState(() {
                    // imageFromPreferences = null;
                  });
                },

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
                IconButton(icon:Icon(Icons.camera_alt,
                  color: Colors.teal,
                  size: 28.0,) ,onPressed: (){

                  pickImageFromGallery(ImageSource.gallery);
                  setState(() {
                    // imageFromPreferences = null;
                    loadImageFromPreferences();
                  });
                },

                ),

              ],
            ) ,
          ],
        ),
      ),
    );
  }
}
