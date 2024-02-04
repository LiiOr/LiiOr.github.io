import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GptScreen extends StatefulWidget {
  const GptScreen({super.key});

  @override
  State<GptScreen> createState() => _GptScreenState();
}

class _GptScreenState extends State<GptScreen> {
  TextEditingController userInputController = TextEditingController();
  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();
  bool isTyping = false;

  List<Map<String, String>> conversation = [];

  typingEffect() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() {
      isTyping = true;
    });
    await Future.delayed(const Duration(milliseconds: 3000));
    isTyping = false;
  }

  addToChat(value, sender) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        userInputController.clear();
      });
      if (sender == 'user') {
        getChatGptResponse(value);
      }
      conversation.add({'message': value, 'sender': sender});
    }
  }

  Future getChatGptResponse(String userMessage) async {
    const apiKey = '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';
    const endpoint = 'https://api.openai.com/v1/chat/completions';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final requestBody = {
      "model": "gpt-3.5-turbo",
      "messages": [{"role": "user", "content": userMessage}]
    };

    final response = await http.post(Uri.parse(endpoint),
        headers: headers, body: json.encode(requestBody));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['choices'][0]['text'];
    } else if (context.mounted) {
      final errorResponse = json.decode(response.body);
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch response from ChatGPT : ${errorResponse['error']['message'].toString()}'),
          duration: const Duration(seconds: 5),
        ),
      );
    } else {
      throw Exception('Failed to fetch response from ChatGPT');}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPT-3 EMBEDDED'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true, // Faites défiler vers le haut (le bas de la liste)
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: conversation.length,
                    itemBuilder: (_, int index) {
                      return Container(
                        margin: conversation[index]['sender']! == 'user'
                            ? const EdgeInsets.only(left: 20.0, bottom: 8.0)
                            : const EdgeInsets.only(right: 20.0, bottom: 8.0),
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: conversation[index]['sender']! == 'user'
                                ? Theme.of(context)
                                    .primaryColor //const Color.fromARGB(255, 240, 200, 233)
                                : Theme.of(context)
                                    .primaryColorLight, //const Color.fromARGB(255, 200, 222, 240),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                        child: Text(
                          conversation[index]['message']!,
                          //style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      );
                    },
                  ),
                  isTyping
                      ? Container(
                          color: const Color.fromARGB(255, 66, 66, 66),
                          height: 40,
                          child: const Center(
                              child: Text('[ Bot is currently typing... ]',
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))))
                      : Container(),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Form(
                          autovalidateMode: _autovalidateMode,
                          key: _formKey,
                          child: Expanded(
                            child: TextFormField(
                              autofocus: true,
                              controller: userInputController,
                              onFieldSubmitted: (value) async {
                                addToChat(value, 'user');
                                // Send user message to ChatGPT API
                                final userMessage = userInputController.text;
                                //final response = await getChatGptResponse(userMessage);

                                setState(() {
                                  //_chatGptResponse = response;
                                  userInputController.clear();
                                });
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type your message ...',
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            addToChat(userInputController.text, 'user');
                            // Send user message to ChatGPT API
                            final userMessage = userInputController.text;
                            //final response = await getChatGptResponse(userMessage);

                            setState(() {
                              //_chatGptResponse = response;
                              userInputController.clear();
                            });
                          },
                          child: Icon(
                            Icons.send,
                            color: Theme.of(context).disabledColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
