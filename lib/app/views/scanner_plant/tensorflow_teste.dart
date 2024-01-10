import 'dart:io';
import 'dart:math';

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

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
      model: "assets/model/model.tflite",
      labels: "assets/model/labels.txt",
    ))!;
    print("Models loading status: $res");
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
          SingleChildScrollView(
              child: Column(
            children: imageSelect
                ? List.generate(
                    _results.length,
                    (index) => maximum == _results[index]['confidence']
                        ? Card(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: Text(
                                "${_results[index]['label']} : ${_results[index]['confidence'].toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  )
                : [],
          ))
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
