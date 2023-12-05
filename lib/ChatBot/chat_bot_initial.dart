import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

import '../Utils/colors_utils.dart';
import '../Utils/string_utils.dart';

class ChatBotInitialScreen extends StatelessWidget {
  const ChatBotInitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SvgPicture.asset('Icons/chat_bot_icon.svg'),
            Text(
              StringUtils.chatBotTitleText,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
                color: ColorUtils.blueColorCardView,
              ),
            ),
            Text(
              StringUtils.howtoHelpChatBotTitleFirst,
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
                color: ColorUtils.chatIconColor,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(250, 60),
                elevation: 2.0,
                backgroundColor: ColorUtils.registerButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
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
              child: Text(
                StringUtils.chatBotButton,
                style: GoogleFonts.roboto(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  color: ColorUtils.emailAddressTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
