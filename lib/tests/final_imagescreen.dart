
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class FinalImageScreen extends StatelessWidget {
  final XFile image;

  const FinalImageScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zoom sur Image'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Image.network(image.path,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}