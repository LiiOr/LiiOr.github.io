import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String image;

  const ImageScreen({super.key, required this.image});

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
          child: Image.memory(
            Uint8List.fromList(base64Decode(image)),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}