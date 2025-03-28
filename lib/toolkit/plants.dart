import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({super.key});

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  String _result = '';
  List<String> _similarImages = [];

  String apiKey = const String.fromEnvironment('PLANT_ID_API_KEY');
  String apiUrl = 'https://plant.id/api/v3/identification';

  Future<void> identifyPlant(String base64Image) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Api-Key': apiKey,
        },
        body: jsonEncode({
          'images': [base64Image],
          'similar_images': true,
          'health': 'auto'
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('HTTP error! status: ${response.statusCode}');
      }

      final data = jsonDecode(response.body);

      if (data['result']['classification']['suggestions'] == null || data['result']['classification']['suggestions'].isEmpty) {
        throw Exception('No plant matches found');
      }

      final result = data['result']['classification']['suggestions'][0];
      final health = data['result']['disease']['suggestions'][0]['name'];
      setState(() {
        _result = 'Name: ${result['name']}\nProbability: ${(result['probability'] * 100).toStringAsFixed(2)}%\n\nDisease: $health';
        _similarImages = (result['similar_images'] as List).map((img) => img['url'] as String).toList();
      });
    } catch (error) {
      setState(() {
        _result = 'Failed to identify plant : $error';
        _similarImages = [];
      });
    }
  }

  pickPlantImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(bytes);
      await identifyPlant(base64Image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PLANT RECOGNITION'),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: pickPlantImage,
                child: const Text('Identify a Plant'),
              ),
              const SizedBox(height: 20),
              Text(_result, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              _similarImages.isNotEmpty
                  ? Column(
                    mainAxisSize: MainAxisSize.min,
                      children: _similarImages.map((url) => Image.network(url)).toList(),
                    )
                  : Container(),
            ],
          ),
        )));
  }
}
