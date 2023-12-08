import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharma_trac/Analytics/top_navigation_bar.dart';
import 'package:pharma_trac/Utils/colors_utils.dart';

import '../../Utils/styleUtils.dart';

class CustomGraphCardView extends StatelessWidget {
  final String title;
  const CustomGraphCardView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TopNavigationBar(vitalSignTitle: title.toString()),
            )
          );
        },
        child: Card(
          elevation: 3.0,
          color: Colors.white,
          shadowColor: ColorUtils.grey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: StyleUtils.robotoTextStyle(),
                    ),
                    SvgPicture.asset('Icons/arrow_forward.svg'),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
