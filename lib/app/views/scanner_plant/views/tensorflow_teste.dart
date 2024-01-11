import 'dart:io';

import 'package:flow_projet/app/views/scanner_plant/data_local/data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:velocity_x/velocity_x.dart';

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
  List<Map<String, dynamic>> planteModels = [];

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

      planteModels =
          planteModel.where((map) => map['nom'] == result[0]['label']).toList();
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
                  child: Image.file(
                    _image,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                  ),
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
          imageSelect
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Maladie(s)",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      ...List.generate(
                          planteModels[0]['maladies'].length,
                          (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                        ),
                                      ),
                                      5.widthBox,
                                      Text(
                                        "${planteModels[0]['maladies'][index]['nomMaladie']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  10.heightBox,
                                  const Text(
                                    "Symptomes",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  10.heightBox,
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Column(
                                      children: [
                                        ...List.generate(
                                          planteModels[0]['maladies'][index]
                                                  ['symptomes']
                                              .length,
                                          (ind) => Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Text(
                                                      "${planteModels[0]['maladies'][index]['symptomes'][ind]}"),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        10.heightBox,
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    "Traitement",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  10.heightBox,
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Column(
                                      children: [
                                        ...List.generate(
                                          planteModels[0]['maladies'][index]
                                                  ['traitement']
                                              .length,
                                          (ind) => Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.green,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Text(
                                                      "${planteModels[0]['maladies'][index]['traitement'][ind]}"),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        10.heightBox,
                                      ],
                                    ),
                                  ),
                                ],
                              ))
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: "prendre une image",
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      imageClassification(image);
    }
  }
}
