import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pharma_trac/Utils/styleUtils.dart';
import '../../Utils/colors_utils.dart';
import '../../Utils/string_utils.dart';
import '../../Utils/timeUtils.dart';
import '../CustomGreyDivider.dart';

class CustomBottomSheetBarVitalSigns extends StatefulWidget {
  final String? bloodPressureLevel;

  const CustomBottomSheetBarVitalSigns(
      {super.key, required this.bloodPressureLevel});

  @override
  State<CustomBottomSheetBarVitalSigns> createState() =>
      _CustomBottomSheetBarVitalSignsState();
}

class _CustomBottomSheetBarVitalSignsState
    extends State<CustomBottomSheetBarVitalSigns> {
  late Future<DateTime?> selectedDate;
  String date = "-";

  late Future<TimeOfDay?> selectedTime;
  String time = "-";

  late int _currentValue = 120;

  @override
  void initState() {
    super.initState();
    // Set the default values for date and time
    date = "Today";
    time = TimeUtils.getFormattedTimeSimple(
        DateTime.now().hour, DateTime.now().minute);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 370.0,
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Update your data",
                        style: StyleUtils.bottomSheetTitleStyle(),
                      ),
                    ),
                  ),
                ],
              ),
              const CustomGreyDivider(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: GestureDetector(
                  onTap: () {
                    showDialogPicker(context);
                  },
                  child: Text(
                    date,
                    style: StyleUtils.bottomSheetTextStyle(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: GestureDetector(
                  onTap: () {
                    showDialogTimePicker(context);
                  },
                  child: Text(
                    time,
                    style: StyleUtils.bottomSheetTextStyle(),
                  ),
                ),
              ),
            ],
          ),
          const CustomGreyDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  StringUtils.bottomSheetBarBloodSugarText,
                  style: StyleUtils.bottomSheetTextStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  StringUtils.bottomSheetBarBloodSugarMeasurementText,
                  style: StyleUtils.bottomSheetTextStyle(),
                ),
              ),
            ],
          ),
          const CustomGreyDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberPicker(
                  minValue: 10,
                  maxValue: 200,
                  value: _currentValue,
                  onChanged: (value) => setState(() => _currentValue = value)),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 60),
                    elevation: 2.0,
                    backgroundColor: ColorUtils.blueColorCardView,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    StringUtils.update,
                    style: GoogleFonts.kiwiMaru(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: ColorUtils.black,
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

  void showDialogPicker(BuildContext context) {
    selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    selectedDate.then((value) {
      setState(() {
        if (value == null) return;
        final now = DateTime.now();
        final diff = now.difference(value).inDays;

        // Check if the selected date is today, yesterday, or another day
        if (diff == 0) {
          date = "Today";
        } else if (diff == 1) {
          date = "Yesterday";
        } else {
          date = TimeUtils.getFormattedDateSimple(value.millisecondsSinceEpoch);
        }
      });
    }, onError: (error) {
      print(error);
    });
  }

  void showDialogTimePicker(BuildContext context) {
    selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              // primary: MyColors.primary,
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: ColorUtils.white,
              surface: ColorUtils.white,
              onSurface: ColorUtils.black,
            ),
            // .dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );
    selectedTime.then((value) {
      setState(() {
        if (value == null) return;
        time = TimeUtils.getFormattedTimeSimple(value.hour, value.minute);
        print(time);
      });
    }, onError: (error) {
      print(error);
    });
  }
}