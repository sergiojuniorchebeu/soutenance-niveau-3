import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';

class ChatGPTInterface extends StatefulWidget {
  const ChatGPTInterface({super.key});

  @override
  _ChatGPTInterfaceState createState() => _ChatGPTInterfaceState();
}

class _ChatGPTInterfaceState extends State<ChatGPTInterface> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pharmacare Gemini',
                style: Appwidget.styledetexte(
                    couleur: Colors.white,
                    taille: 20,
                    w: FontWeight.bold)),
            const SizedBox(width: 10,),
            Image.asset(
              "assets/img/pharmacie (1).png",
              height: 40,
            )
          ],
        ),
        backgroundColor: Appwidget.customGreen,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(_messages[index]),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    maxLines: 3,
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Entrez un message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, size: 40,),
                  onPressed: _sendMessage,
                  color: Appwidget.customGreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}