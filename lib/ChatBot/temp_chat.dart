import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    if (text != null && text.trim().isNotEmpty) {
      ChatMessage userMessage = ChatMessage(text: text, isUser: true);
      setState(() {
        _messages.add(userMessage);
        // Clear the input field after the message is sent
        _textController.clear();
      });

      // Respond to the user's input
      _botResponse(text);
    }
  }

  void _botResponse(String userMessage) {
    // Simulate bot response after a short delay
    String response = 'Default bot response...';

    if (userMessage.toLowerCase().contains('hello')) {
      response = 'Hi there!';
    } else if (userMessage.toLowerCase().contains('goodbye')) {
      response = 'Goodbye!';
    } else {
      // Add more conditions based on user input
    }

    // Simulate bot response after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      ChatMessage botMessage = ChatMessage(text: response, isUser: false);
      setState(() {
        _messages.add(botMessage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Bot'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: false,
              itemCount: _messages.length,
              itemBuilder: (_, int index) {
                // Map ChatMessage objects to Bubble widgets
                return Bubble(
                  message: _messages[index].text,
                  isUser: _messages[index].isUser,
                );
              },
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const Bubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: isUser
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor,
              borderRadius: isUser
                  ? const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              )
                  : const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}