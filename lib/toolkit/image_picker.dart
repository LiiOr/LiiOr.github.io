import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:minijeux/toolkit/imagescreen.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({super.key});

  @override
  State<ImagePicker> createState() => ImagePickerState();
}

class ImagePickerState extends State<ImagePicker> {
  List<String> imgList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('I M A G E  P I C K E R'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Test de charge',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('Package image_picker 1.0.4.'),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: ElevatedButton.icon(
                  label: const Text('Pick images'),
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

  Future<void> _pickImage() async {
  try {
    final picker = ImagePickerWeb();

    // Utilisez picker.getImage pour ouvrir la boîte de dialogue de prise de photo.
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // La photo a été prise avec succès.
      // Vous pouvez maintenant afficher l'image ou la traiter comme vous le souhaitez.

      // Convertissez l'image en base64 pour l'afficher dans votre ListView.
      final imageBytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(imageBytes);

      // Mettez à jour la liste d'images.
      setState(() {
        imgList.add(base64Image);
      });
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
      ),
    );
  }
}


}
