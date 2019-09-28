import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:hamagon/model/pest_repo.dart';
import 'package:image_picker/image_picker.dart';

class ImageMain extends StatefulWidget {
  @override
  _ImageMainState createState() => _ImageMainState();
}

class _ImageMainState extends State<ImageMain> {
  File imageFile;
  List<Pest> _pest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _getImageAndDetectLabel,
        tooltip: 'Pilih gambar',
        child: Icon(Icons.add_a_photo),
      ),
      body: PreviewImage(imageFile: imageFile,),
    );
  }

  void _getImageAndDetectLabel() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (mounted) {
      setState(() {
      this.imageFile = imageFile;
      });
    }
    // final image = FirebaseVisionImage.fromFile(imageFile);
    // final imageLabelling = FirebaseVision.instance
    //     .labelDetector(LabelDetectorOptions(confidenceThreshold: 0.3));
  }
}

class PreviewImage extends StatelessWidget {
  PreviewImage({this.imageFile});
  final File imageFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Container(
            constraints: BoxConstraints.expand(),
            child: Image.file(
              imageFile,
              fit: BoxFit.cover
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Center(
            child: RaisedButton(
              onPressed: () {},
              child: Text("Cari"),
            ),
          )
        )
      ],
    );
  }
}