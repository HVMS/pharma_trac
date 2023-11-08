import 'package:flutter/material.dart';

import '../Utils/colors_utils.dart';

class CustomGreyDivider extends StatelessWidget{
  const CustomGreyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Divider(
      thickness: 2.0,
      color: ColorUtils.grey,
    );
  }

}