import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma_trac/Utils/string_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/colors_utils.dart';

class EditProfileScreen extends StatelessWidget{
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringUtils.editScreenAppBarTitle,
          style: GoogleFonts.roboto(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: ColorUtils.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          StringUtils.name,
                          style: GoogleFonts.kiwiMaru(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: ColorUtils.black,
                          ),
                        ),
                        Text(
                          StringUtils.userFullName,
                          style: GoogleFonts.kiwiMaru(
                            fontSize: 15.0,
                            color: ColorUtils.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset('Icons/arrow_forward.svg'),
                    onPressed: () {  },
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Divider(
                height: 20.0,
                thickness: 2.0,
                color: ColorUtils.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          StringUtils.emailAddress,
                          style: GoogleFonts.kiwiMaru(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: ColorUtils.black,
                          ),
                        ),
                        Text(
                          StringUtils.userFullName,
                          style: GoogleFonts.kiwiMaru(
                            fontSize: 15.0,
                            color: ColorUtils.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset('Icons/arrow_forward.svg'),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Divider(
                height: 20.0,
                thickness: 2.0,
                color: ColorUtils.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          StringUtils.countryName,
                          style: GoogleFonts.kiwiMaru(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: ColorUtils.black,
                          ),
                        ),
                        Text(
                          StringUtils.userFullName,
                          style: GoogleFonts.kiwiMaru(
                            fontSize: 15.0,
                            color: ColorUtils.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset('Icons/arrow_forward.svg'),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Divider(
                height: 20.0,
                thickness: 2.0,
                color: ColorUtils.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          StringUtils.height,
                          style: GoogleFonts.kiwiMaru(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: ColorUtils.black,
                          ),
                        ),
                        Text(
                          StringUtils.userFullName,
                          style: GoogleFonts.kiwiMaru(
                            fontSize: 15.0,
                            color: ColorUtils.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset('Icons/arrow_forward.svg'),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Divider(
                height: 20.0,
                thickness: 2.0,
                color: ColorUtils.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          StringUtils.weight,
                          style: GoogleFonts.kiwiMaru(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: ColorUtils.black,
                          ),
                        ),
                        Text(
                          StringUtils.userFullName,
                          style: GoogleFonts.kiwiMaru(
                            fontSize: 15.0,
                            color: ColorUtils.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset('Icons/arrow_forward.svg'),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
