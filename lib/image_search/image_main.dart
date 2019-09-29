import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:hamagon/model/pest_repo.dart';
import 'package:hamagon/result/result_list.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';

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
          ? Column(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    child: Image.file(imageFile, fit: BoxFit.cover),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: RaisedButton(
                      onPressed: _detectLabel,
                      child: Text("Cari"),
                    ),
                  ),
                )
              ],
            )
          : Column(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    child: placeholder,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(),
                )
              ],
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
    log("detectlabel started");
    final FirebaseVisionImage image = FirebaseVisionImage.fromFile(imageFile);
    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler(
      ImageLabelerOptions(confidenceThreshold: 0.1),
    );

    final List<ImageLabel> labels = await labeler.processImage(image);
    
    log("getresults");
    List<Pest> pests = [];
    for (ImageLabel label in labels) {
      log("label printed");
      pests.add(Pest(label.text, label.confidence));
      final String text = label.text;
      final double confidence = label.confidence;
    }


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultList(results: pests),
      ),
    );
    // _getResults(labels);  
  }

  void _getResults(List<ImageLabel> labels) {
    log("getresults");
    List<Pest> pests;
    for (ImageLabel label in labels) {
      pests.add(Pest(label.text, label.confidence));
      final String text = label.text;
      final double confidence = label.confidence;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultList(results: pests),
      ),
    );
    // _navigateToResult(pests);
  }

  void _navigateToResult(List<Pest> pests) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultList(results: pests),
      ),
    );
  }
}

// class PreviewImage extends StatelessWidget {
//   PreviewImage({this.image});

//   final Image image;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Flexible(
//           flex: 2,
//           child: Container(
//             constraints: BoxConstraints.expand(),
//             child: image,
//           ),
//         ),
//         Flexible(
//             flex: 1,
//             child: Center(
//               child: RaisedButton(
//                 onPressed: () {},
//                 child: Text("Cari"),
//               ),
//             ))
//       ],
//     );
//   }
// }
