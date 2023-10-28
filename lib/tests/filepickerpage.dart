import 'dart:convert';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minijeux/tests/imagescreen.dart';

class FilepickerPage extends StatefulWidget {
  const FilepickerPage({super.key});

  @override
  State<FilepickerPage> createState() => FilepickerPageState();
}

class FilepickerPageState extends State<FilepickerPage> {
  List<String> imgList = [];

  Future<void> _pickImage() async {
    FilePickerResult? result =
        await FilePickerWeb.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      for (int i = 0; i < result.files.length; i++) {
        PlatformFile file = result.files[i];
        List<int> imageBytes = file.bytes ?? [];
        String base64Image = base64Encode(imageBytes);
        imgList.add(base64Image);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('F I L E P I C K E R'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom:15.0),
              child: ElevatedButton.icon(
                  label: const Text('Pick files'),
                  onPressed: _pickImage,
                  icon: const Icon(Icons.add_a_photo)),
            ),
            if (imgList.isNotEmpty)
              SizedBox(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: imgList.length,
                    itemBuilder: (context, indexImage) {
                      var image = imgList[indexImage];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          child: Stack(children: [
                            Image.memory(
                              Uint8List.fromList(base64Decode(image)),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.pink,
                                  ),
                                  onPressed: () => setState(() {
                                        imgList.removeAt(indexImage);
                                      })),
                            ),
                          ]),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ImageScreen(image: image),
                              ),
                            );
                          },
                        ),
                      );
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
