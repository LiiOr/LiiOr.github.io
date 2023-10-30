import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class ColorBook extends StatefulWidget {
  const ColorBook({Key? key}) : super(key: key);

  @override
  State<ColorBook> createState() => _ColorBookState();
}

class _ColorBookState extends State<ColorBook> {
  img.Image? coloringImage;
  img.Image? coloredImage;
  bool isImageLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final data = await rootBundle.load('assets/cow.png');
    final bytes = data.buffer.asUint8List();
    coloringImage = img.decodeImage(Uint8List.fromList(bytes));
    coloredImage = coloringImage;
    setState(() {
      isImageLoaded = true;
    });
  }

  void colorPixel(int x, int y, img.Color color) {
    if (color != Colors.black) {
      coloredImage!.setPixel(x, y, color);
      setState(() {
        // Redessinez la zone d'affichage de l'image coloriée.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C O L O R B O O K'),
      ),
      body: isImageLoaded
          ? GestureDetector(
              onTapUp: (details) {
                final RenderBox renderBox = context.findRenderObject() as RenderBox;
                final localPosition = renderBox.globalToLocal(details.globalPosition);
                final x = (localPosition.dx / renderBox.size.width * coloringImage!.width).toInt();
                final y = (localPosition.dy / renderBox.size.height * coloringImage!.height).toInt();
                colorPixel(x, y, const Color.fromARGB(255, 83, 3, 83) as img.Color); // Couleur rouge
              },
              child: Image.memory(Uint8List.fromList(img.encodePng(coloredImage!))),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
