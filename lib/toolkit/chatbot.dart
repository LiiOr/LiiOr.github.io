import 'dart:math';

import 'package:flutter/material.dart';

class ChatbotGame extends StatefulWidget {
  const ChatbotGame({super.key});

  @override
  State<ChatbotGame> createState() => _ChatbotGameState();
}

class _ChatbotGameState extends State<ChatbotGame> {
  TextEditingController userInputController = TextEditingController();
  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();
  bool isTyping = false;

  List<List<String>> q = [
    ["Hey", "Hi", "Hello", "Bonjour", "Salut", "Coucou", "Plop"],
    ["Ca va?", "Comment va?"],
    ["Qui es tu?"]
  ];
  List<List<String>> a = [
    ["Hi bro", "Oh, hey !", "Helloooo :)", "Salut !", "Plop", "Salut", "Coucou"],
    ["Très bien, merci. Et toi??", "Super et toi?"],
    ["Je suis un (modeste) chatbot."]
  ];
  List<String> alternatives = [
    "Doucement, doucement ! Je ne suis qu'un bot !",
    "Hein, quoi ??",
    "Eh, mais tu m'as pris pour CHAT GPT ou quoi ?",
    "Aîe... ma tête..",
  ];

  List<Map<String, String>> conversation = [];

  readAndAnswer(value, sender) async {
    await typingEffect(); // Attendre que typingEffect soit terminé
    bool found = false;
    for (int i = 0; i < q.length; i++) {
      for (int j = 0; j < q[i].length; j++) {
        if (value.toString().toLowerCase() == q[i][j].toLowerCase()) {
          addToChat(a[i][j], 'bot');
          found = true;
          break;
        }
      }
    }
    if (!found) {
      addToChat(alternatives[Random().nextInt(alternatives.length)], 'bot');
    }
  }

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
        conversation.add({'message': value, 'sender': sender});
        userInputController.clear();
      });
      if (sender == 'user') {
        readAndAnswer(value, sender);
      }
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
        title: const Text('C H A T B O T'),
        //backgroundColor: Theme.of(context).primaryColor,
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
                      ? Container(color: const Color.fromARGB(255, 66, 66, 66), height: 40, child: const Center(child: Text('[ Bot is currently typing... ]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))))
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
                              onFieldSubmitted: (value) {
                                addToChat(value, 'user');
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type your message ...',
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            addToChat(userInputController.text, 'user');
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
