import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class TensorFlowTest extends StatefulWidget {
  const TensorFlowTest({super.key});

  @override
  State<TensorFlowTest> createState() => _TensorFlowTestState();
}

class _TensorFlowTestState extends State<TensorFlowTest> {
  late File _image;
  late List _results;
  double maximum = 0;
  bool imageSelect = false;
  List result = [];

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    await Tflite.loadModel(
      model: "assets/model/model.tflite",
      labels: "assets/model/labels.txt",
    );
  }

  Future imageClassification(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
      maximum = _results.reduce((acc, map) =>
          acc["confidence"] > map["confidence"] ? acc : map)["confidence"];
      result = _results.where((map) => map["confidence"] == maximum).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          imageSelect
              ? Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.file(_image),
                )
              : Container(
                  margin: const EdgeInsets.all(10),
                  child: const Opacity(
                    opacity: 0.8,
                    child: Center(
                      child: Text("Aucune image selectionner"),
                    ),
                  ),
                ),
          imageSelect
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: Card(
                    child: Container(
                      // margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "${result[0]['label']} : ${result[0]['confidence'].toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: "prendre une image",
        child: const Icon(Icons.image_search),
      ),
    );
  }

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
  }
}
