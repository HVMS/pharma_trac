import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma_trac/customWidgets/editProfileBottomSheetBar.dart';

import '../Utils/styleUtils.dart';

class CustomEditProfileRow extends StatelessWidget {
  final String title;
  final String value;

  const CustomEditProfileRow(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: StyleUtils.robotoTextStyle(),
              ),
              Text(
                value,
                style: StyleUtils.robotoLightTextStyle(),
              ),
            ],
          ),
        ),
        IconButton(
          icon: SvgPicture.asset('Icons/arrow_forward.svg'),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return EditProfileBottomSheetBar(
                  titleValue: title,
                  responseValue: value,
                  onUpdate: (updatedUser) {
                    // Update the local state with the new user information
                  },
                );
              },
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
            );
          },
        ),
      ],
    );
  }
}
