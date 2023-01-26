import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

import 'package:image_picker/image_picker.dart';

class result extends StatefulWidget {


  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {


  late File pickedImage;
  bool isImageLoaded = false;
  late List result;
  String confidence ="";
  String name ="";
  String numbers ="";






  getImageFromGallery() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(tempStore!.path);
      isImageLoaded = true;
      applyModelOnImage(pickedImage);
    });
  }
  loadMyModel()async{
    var resultant = await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/labels.txt"
    );
    print("Result after loading model:$resultant");
  }
  applyModelOnImage(File file)async{
    try {
      var res = await Tflite.runModelOnImage(
          path: file.path,
          numResults: 2,
          threshold: .5,
          imageMean: 127.5,
          imageStd: 127.5);
      setState(() {

          result = res!;
          String str = result[0]["label"];
          name = str.substring(0);
          confidence = result != null ? "${(result[0]['confidence']*100.0).toString().substring(0, 2)}%" : "";
          print(name);
          print(confidence);

      });
    }catch(error){
      print('error 2');
    }
  }
  @override
  void initState(){

    loadMyModel();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('TFLite Demo'),),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30,),
            isImageLoaded
                ? Center(

              child: Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(File(pickedImage.path)),
                        fit: BoxFit.contain
                    )
                ),
              ),
            )
                : Container(),
            SizedBox(height: 30,),
            Text("Name : $name \n Confidence $confidence"),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImageFromGallery();
        },
        child: Icon(Icons.photo_album),
      ),
    );
  }
}
