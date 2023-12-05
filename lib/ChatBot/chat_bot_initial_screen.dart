import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

import '../Utils/colors_utils.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotInitialScreenState();
}

class _ChatBotInitialScreenState extends State<ChatBotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic conversationObject = {
            'appId':
                '333e636f57fd928adbb401455aa821a60', // The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
          };

          KommunicateFlutterPlugin.buildConversation(conversationObject)
              .then((clientConversationId) {
            print("Conversation builder success : $clientConversationId");
          }).catchError((error) {
            print("Conversation builder error : $error");
          });
        },
        backgroundColor: ColorUtils.floatingActionButtonColor,
        child: const Icon(Icons.chat_outlined, size: 25.0, color: Colors.white),
      ),
    );
  }
}
