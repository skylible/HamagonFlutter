// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';
import 'dart:io';

import 'package:automl_mlkit/automl_mlkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hamagon/model/pest_repo.dart';
import 'package:hamagon/result/result_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MainImage());

class MainImage extends StatefulWidget {
  @override
  _MainImageState createState() => _MainImageState();
}

class _MainImageState extends State<MainImage> {
  String _modelLoadStatus = 'unknown';
  File _imageFile;
  String _inferenceResult;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    String dataset = "botol";
    await createLocalFiles(dataset);
    String modelLoadStatus;
    try {
      await AutomlMlkit.loadModelFromCache(dataset: dataset);
      modelLoadStatus = "AutoML model successfully loaded";
    } on PlatformException catch (e) {
      modelLoadStatus = "Error loading model";
      print("error from platform on calling loadModelFromCache");
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _modelLoadStatus = modelLoadStatus;
    });
  }

  Future<void> createLocalFiles(String folder) async {
    Directory tempDir = await getTemporaryDirectory();
    final Directory modelDir = Directory("${tempDir.path}/$folder");
    if (!modelDir.existsSync()) {
      modelDir.createSync();
    }
    final filenames = ["manifest.json", "model.tflite", "dict.txt"];

    for (String filename in filenames) {
      final File file = File("${modelDir.path}/$filename");
      if (!file.existsSync()) {
        print("Copying file: $filename");
        await copyFileFromAssets(filename, file);
      }
    }
  }

  /// copies file from assets to dst file
  Future<void> copyFileFromAssets(String filename, File dstFile) async {
    ByteData data = await rootBundle.load("assets/$filename");
    final buffer = data.buffer;
    dstFile.writeAsBytesSync(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<void> loadImageAndInfer(context) async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile == null) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Gambar tidak bisa dibaca")));
      return;
    }

    final results =
        await AutomlMlkit.runModelOnImage(imagePath: imageFile.path);
    // print("Got results" + results[0].toString());

    if (results.isEmpty) {
      print("Context dari page ini adalah:" + context.toString());
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Hama tidak ditemukan")));
      setState(() {
        _imageFile = imageFile;
        _inferenceResult = null;
      });
    } else {
      final label = results[0]["label"];
      final confidence = (results[0]["confidence"] * 100).toStringAsFixed(2);
      setState(() {
        _imageFile = imageFile;
        _inferenceResult = "$label: $confidence \%";
      });

      // Get pest data
      List<Pest> pests = [];

      for (var result in results) {
        Firestore.instance
            .collection('test_labels')
            .where("name", isEqualTo: result["label"])
            .snapshots()
            .listen(
              (data) => data.documents.forEach(
                (doc) {
                  print(doc["name"]);
                  pests.add(
                    Pest(doc['image_url'], doc["name"], doc["description"],
                        doc["recommendation"], doc["host_tree"],
                        confidence: result['confidence']),
                  );

                  // Navigate to list of pests code
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultList(results: pests)));
                },
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Pencarian Gambar"),
          backgroundColor: Color(0xff628336),
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30)))),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _inferenceResult == null
                    ? Container()
                    : Text(
                        "$_inferenceResult",
                        style: TextStyle(fontSize: 20),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _imageFile == null
                      ? Container()
                      : Container(
                          height: 200,
                          child: Image.file(_imageFile),
                        ),
                ),
                //       Container(
                //         margin: const EdgeInsets.only(bottom: 0),
                //         height: 300,
                //         width: 300,
                //         child: Icon(
                //         Icons.file_upload,
                //         color: Color(0xff628336),
                //         size: 300.0,
                //       ),
                // ),

                Container(
                  width: 216,
                  height: 40,
                  child: RaisedButton(
                    elevation: 3,
                      color: Color(0xff628336),
                      onPressed: () => {loadImageAndInfer(context)},
                      textColor: Colors.white,
                      child: Text("Pilih Foto"),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 28),
                //   child: Text('Status A.I: $_modelLoadStatus\n'),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
