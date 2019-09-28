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
  Image placeholder = Image.asset('assets/images/bug.jpg');
  List<Pest> _pest;
  bool imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Pilih gambar',
        child: Icon(Icons.add_a_photo),
      ),
      body: imageLoaded
          ? PreviewImage(
              image: Image.file(imageFile, fit: BoxFit.cover),
            )
          : PreviewImage(
              image: placeholder,
            ),
    );
  }

  void _getImage() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (mounted) {
      setState(() {
        this.imageFile = imageFile;
        this.imageLoaded = true;
      });
    }
  }

  void _detectLabel() async {
    final FirebaseVisionImage image = FirebaseVisionImage.fromFile(imageFile);
    final LabelDetector labeler = FirebaseVision.instance.labelDetector(
      LabelDetectorOptions(confidenceThreshold: 0.60),
    );

    final List<Label> labels = await labeler.detectInImage(image);

    
  }
}

class PreviewImage extends StatelessWidget {
  PreviewImage({this.image});

  final Image image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Container(
            constraints: BoxConstraints.expand(),
            child: image,
          ),
        ),
        Flexible(
            flex: 1,
            child: Center(
              child: RaisedButton(
                onPressed: () {},
                child: Text("Cari"),
              ),
            ))
      ],
    );
  }
}
