import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mylabs/tests/imagescreen.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class FilepickerPage extends StatefulWidget {
  const FilepickerPage({super.key});

  @override
  State<FilepickerPage> createState() => FilepickerPageState();
}

class FilepickerPageState extends State<FilepickerPage> {
  List<Uint8List> imgList = [];

  @override
  void dispose() {
    imgList.clear();
    imageCache.clear();
    super.dispose();
  }


  _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image, allowMultiple: true, allowCompression: true);
      if (result != null && result.files.isNotEmpty) {
        for (int i = 0; i < result.files.length; i++) {
          PlatformFile file = result.files[i];
          Uint8List? imageBytes = file.bytes!;
          Uint8List? compressedImage = await compressImage(imageBytes);
          imgList.add(compressedImage);
          //imageBytes = null;
          //compressedImage = null;
        }
        /*imageCache.clear();
        result.files.clear();
        result = null;*/
        setState(() {});
      }
    } catch (e) {
      throw Exception('Picking images failed : $e');
    }
  }

  Future<Uint8List> compressImage(Uint8List imageBytes) async {
    var result = await FlutterImageCompress.compressWithList(imageBytes, minWidth: 500, minHeight: 500, quality: 25);
    return Uint8List.fromList(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('F I L E P I C K E R'),
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
            const Text('Package file_picker 5.5.0.'),
            const Divider(),
            Text('Current image cache >> ${imageCache.currentSizeBytes} bytes'),
            Text('Maximum cache size >>> ${imageCache.maximumSizeBytes} bytes'),
            Text('Percents of cache used >>> ${(imageCache.currentSizeBytes / imageCache.maximumSizeBytes * 100).toStringAsFixed(2).toString()} %'),
            Text('Current image count in cache: ${imageCache.currentSize}'),
            Text('Maximum image count in cache: ${imageCache.maximumSize}'),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: ElevatedButton.icon(
                  label: const Text('Pick files'),
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
                              cacheWidth: 100,
                              cacheHeight: 100,
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
                                        imageCache.clearLiveImages();
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
