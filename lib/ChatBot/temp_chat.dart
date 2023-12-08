import 'package:flutter/material.dart';

import '../services/medicine_api.dart';
import 'bubble.dart';
import 'bubble_dot.dart';
import 'package:fuzzy/fuzzy.dart';

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
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Add initial bot messages when the chat screen is first loaded
    _addBotMessages([
      "Hi there, I am Pharmie. How are you doing today?",
      "I can help you to find drug side effects.",
      "Can you please tell me the drug name?",
    ]);
  }

  void _addBotMessages(List<String> messages) {
    _startTypingIndicator();
    Future.delayed(const Duration(seconds: 2), () {
      for (String message in messages) {
        ChatMessage botMessage = ChatMessage(text: message, isUser: false);
        setState(() {
          _messages.add(botMessage);
        });
      }
    });
  }

  void _startTypingIndicator() {
    setState(() {
      _isTyping = true;
    });
    // Stop typing indicator after a short delay (simulate typing)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTyping = false;
      });
    });
  }

  String _formatSideEffects(List<String?> sideEffects) {
    String formattedMessage = '';
    for (var i = 0; i < sideEffects.length; i++) {
      formattedMessage += '${i + 1}. ${sideEffects[i]}\n';
    }
    return formattedMessage;
  }

  Future<void> _handleSubmitted(String text) async {
    ChatMessage userMessage = ChatMessage(text: text, isUser: true);
    setState(() {
      _messages.add(userMessage);
      // Clear the input field after the message is sent
      _textController.clear();
    });

    // Respond to the user's input
    _botResponse(text);
  }

  Future<String> _getDrugInList(String userMessage) async {
    try {
      // Fetch the list of medicines from the API
      List<String> medicineList = await MedicineAPI.getMedicineList();
      print(medicineList.length);

      String userSentence = userMessage.toLowerCase();
      final fuse = Fuzzy(medicineList,
          options: FuzzyOptions(
              findAllMatches: false, tokenize: true, threshold: 0.3));
      final result = fuse.search(userSentence);

      // Check if there are any matches
      if (result.isNotEmpty) {
        // Get the nearest match (the first result)
        String nearestMatch = result[0].item;
        return nearestMatch;
      } else {
        return ''; // No matching medicine found
      }
    } catch (e) {
      // Handle any errors that may occur during the API call
      debugPrint(e.toString());
      return '';
    }
  }

  Future<void> _botResponse(String userMessage) async {
    _startTypingIndicator();

    // Simulate bot response after a short delay
    String response = 'Default bot response...';

    // Define regex patterns for user greetings and well-being messages
    RegExp wellBeingRegex = RegExp(
        r'hello|hi|am\s+good|doing\s+good|really\s+well|\bdoing\s+well\b|\bwell\b');

    if (wellBeingRegex.hasMatch(userMessage.toLowerCase())) {
      _startTypingIndicator();
      response = 'Awesome!! Which drug did you take?';

      // Simulate bot response after a short delay
      Future.delayed(const Duration(seconds: 2), () {
        ChatMessage botMessage = ChatMessage(text: response, isUser: false);
        setState(() {
          _messages.add(botMessage);
        });
      });
    } else if (userMessage.toLowerCase().contains('goodbye')) {
      _startTypingIndicator();
      response = 'Goodbye!';

      // Simulate bot response after a short delay
      Future.delayed(const Duration(seconds: 2), () {
        ChatMessage botMessage = ChatMessage(text: response, isUser: false);
        setState(() {
          _messages.add(botMessage);
        });
      });
    } else {
      _startTypingIndicator();
      // Add more conditions based on user input

      String medicineName = await _getDrugInList(userMessage);
      print(medicineName);

      List<String?>? medicineSideEffectsList =
          await callAPIToGetSideEffects(medicineName);
      print("data is $medicineSideEffectsList");
      if (medicineSideEffectsList!.isNotEmpty) {

        print(medicineSideEffectsList.toList());

        String sideEffectsMessage = "Here are the known side effects of $medicineName:\n" +
            "${_formatSideEffects(medicineSideEffectsList.toList())}";

        // Simulate bot response after a short delay
        Future.delayed(const Duration(seconds: 2), () {
          ChatMessage botMessage =
          ChatMessage(text: sideEffectsMessage, isUser: false);
          setState(() {
            _messages.add(botMessage);
          });
        });

      } else {
        String noSideEffectsMessage = "Apologies, there is no side effects of $medicineName.";
        Future.delayed(const Duration(seconds: 2), () {
          ChatMessage botMessage =
          ChatMessage(text: noSideEffectsMessage, isUser: false);
          setState(() {
            _messages.add(botMessage);
          });
        });
      }


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmie Chat'),
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
          if (_isTyping) _buildTypingIndicator(),
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
                cursorColor: Colors.blueAccent,
                maxLines: 2,
                autocorrect: true,
                enableSuggestions: true,
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Start chat here ...',
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

  Widget _buildTypingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BubbleDot(),
          BubbleDot(),
          BubbleDot(),
        ],
      ),
    );
  }

  Future<List<String?>?> callAPIToGetSideEffects(String medicineName) async {
    try {
      List<String?>? medicineSideEffectsResponse =
          await MedicineAPI.getMedicineSideEffectsList(medicineName);

      if (medicineSideEffectsResponse!.isNotEmpty) {
        return medicineSideEffectsResponse;
      }

      return [];
    } catch (e) {
      // Handle any errors that may occur during the API call
      print('Error during API call: $e');
      return [];
    }
  }
}
