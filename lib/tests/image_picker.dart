import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mylabs/tests/imagescreen.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => ImagePickerScreenState();
}

class ImagePickerScreenState extends State<ImagePickerScreen> {
  final ImagePicker picker = ImagePicker();
  List<Uint8List> imgList = [];

  @override
  void dispose() {
    imgList.clear();
    imageCache.clear();
    super.dispose();
  }

  _pickImage() async {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        Uint8List imageBytes = await pickedFile.readAsBytes();
        if (imageBytes.isNotEmpty) {
          Uint8List compressedImage = await compressImage(imageBytes);
          imgList.add(compressedImage);
          //imageCache.clear();
        }
      }
      setState(() {});
  }

  Future<Uint8List> compressImage(Uint8List imageBytes) async {
    var compressedBytes = await FlutterImageCompress.compressWithList(
        imageBytes,
        minWidth: 500,
        minHeight: 500,
        quality: 25);
    return compressedBytes;
  }


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
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text('Test de charge',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const Text('Package image_picker 1.0.5.'),
            const Divider(),
            Text('Current image cache >> ${imageCache.currentSizeBytes} bytes'),
            Text('Maximum cache size >>> ${imageCache.maximumSizeBytes} bytes'),
            Text('Percents of cache used >>> ${imageCache.currentSizeBytes / imageCache.maximumSizeBytes * 100} %'),
            Text('Current image count in cache: ${imageCache.currentSize}'),
            Text('Maximum image count in cache: ${imageCache.maximumSize}'),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: ElevatedButton.icon(
                  label: const Text('Pick images'),
                  onPressed: () {
                    _pickImage();
                  },
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
                              image,
                              width: 100,
                              height: 100,
                              cacheHeight: 100,
                              cacheWidth: 100,
                              filterQuality: FilterQuality.low,
                              scale: 1.0,
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