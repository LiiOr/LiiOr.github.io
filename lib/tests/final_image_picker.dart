import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mylabs/tests/final_imagescreen.dart';

class FinalImagePickerScreen extends StatefulWidget {
  const FinalImagePickerScreen({super.key});

  @override
  State<FinalImagePickerScreen> createState() => ImagePickerScreenState();
}

class ImagePickerScreenState extends State<FinalImagePickerScreen> {
  final ImagePicker picker = ImagePicker();
 List<XFile> _mediaFileList = [];

  @override
  void dispose() {
   _mediaFileList.clear();
    imageCache.clear();
    super.dispose();
  }

  _pickImage() async {
      final List<XFile> pickedFile = await picker.pickMultiImage(maxHeight: 500, maxWidth: 500, imageQuality: 25);
      setState(() {
        _mediaFileList.addAll(pickedFile);
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('F I N A L  I M A G E  P I C K E R'),
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
            Text('Percents of cache used >>> ${(imageCache.currentSizeBytes / imageCache.maximumSizeBytes * 100).toStringAsFixed(2).toString()} %'),
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
            if (_mediaFileList != null)
              SizedBox(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: _mediaFileList!.length,
                    itemBuilder: (context, indexImage) {
                      var image = _mediaFileList![indexImage];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          child: Stack(children: [
                            Image.network(
                              image.path,
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
                                        _mediaFileList!.removeAt(indexImage);
                                      })),
                            ),
                          ]),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FinalImageScreen(image: image),
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