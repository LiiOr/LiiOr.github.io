import 'package:flutter/material.dart';

class ChatbotGame extends StatefulWidget {
  const ChatbotGame({super.key});

  @override
  State<ChatbotGame> createState() => _ChatbotGameState();
}

class _ChatbotGameState extends State<ChatbotGame> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();
  TextEditingController userInputController = TextEditingController();

  List<List<String>> q = [
    ["Hey", "Hi", "Hello"]
  ];
  List<List<String>> a = [
    ["Oh, hey !", "Hi bro", "Helloooo :)"]
  ];

  List<String> conversation = [];

  addToChat(value) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        conversation.add(userInputController.text);
        userInputController.clear();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(' CH A T B O T'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        //body: const Center(child: Text('Coming soon.. :)')));
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              itemCount: conversation.length, //_messages.length,
              itemBuilder: (_, int index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  padding: const EdgeInsets.all(15.0),
                  // height: 80,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 240, 200, 233),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Text(
                    conversation[index],
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                );
              },
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              decoration: BoxDecoration(
                  //color: Color.fromARGB(255, 236, 236, 236),
                  border: Border.all(width: 1.0, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: TextFormField(
                        controller: userInputController,
                        onFieldSubmitted: (value) {
                          addToChat(value);
                        },
                        decoration: const InputDecoration(
                          //border: OutlineInputBorder(),
                          border: InputBorder.none,
                          hintText: 'Type your message ...',
                          //hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.send,
                    color: Theme.of(context).disabledColor,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
