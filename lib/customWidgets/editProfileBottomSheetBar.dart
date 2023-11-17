import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../Utils/colors_utils.dart';
import '../Utils/string_utils.dart';
import '../model/User/update_user_response.dart';
import '../services/users_api.dart';
import 'CustomGreyDivider.dart';

class EditProfileBottomSheetBar extends StatefulWidget {
  final String titleValue;
  final String responseValue;

  const EditProfileBottomSheetBar(
      {super.key, required this.titleValue, required this.responseValue});

  @override
  State<StatefulWidget> createState() => _EditProfileBottomSheetBar();
}

class _EditProfileBottomSheetBar extends State<EditProfileBottomSheetBar> {

  final TextEditingController _textController = TextEditingController();
  late Box userDataBox;

  @override
  void initState() {
    super.initState();
    // Set the initial value of the TextField
    _textController.text = widget.responseValue;
    userDataBox = Hive.box('userData');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: SvgPicture.asset('Icons/close_button_icon.svg'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Update your ${widget.titleValue}",
                        style: GoogleFonts.kiwiMaru(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const CustomGreyDivider(),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter your text',
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              const CustomGreyDivider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 60),
                    elevation: 2.0,
                    backgroundColor: ColorUtils.registerButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () async {
                    String userId = userDataBox.get('_id', defaultValue: '');
                    Map<String, dynamic> updateInfo = { "fullName" : _textController.text };

                    print(userId);
                    print(updateInfo);

                    try {
                      UpdateUserResponseUpdatedUser? responseData = await UsersAPI
                          .updateUserInformation(userId, updateInfo);

                      print(responseData);

                    } catch (e) {
                      print(e);
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    StringUtils.update,
                    style: GoogleFonts.kiwiMaru(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: ColorUtils.emailAddressTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
