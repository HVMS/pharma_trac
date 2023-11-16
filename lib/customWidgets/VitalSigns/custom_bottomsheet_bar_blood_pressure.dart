import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../Utils/colors_utils.dart';
import '../../Utils/string_utils.dart';
import '../../Utils/styleUtils.dart';
import '../../Utils/timeUtils.dart';
import '../../services/vital_signs_api.dart';
import '../CustomGreyDivider.dart';

class BloodPressureCustomBottomSheetBar extends StatefulWidget {
  final String? vitalSignText;
  final Color? buttonColor;
  final String? vitalSignMeasurementText;

  const BloodPressureCustomBottomSheetBar(
      {super.key,
        required this.vitalSignText,
        required this.buttonColor,
        this.vitalSignMeasurementText});

  @override
  State<BloodPressureCustomBottomSheetBar> createState() => _BloodPressureCustomBottomSheetBarState();
}

class _BloodPressureCustomBottomSheetBarState extends State<BloodPressureCustomBottomSheetBar> {

  late Future<DateTime?> selectedDate;
  String date = "-";

  String dateToBeSent = "-";

  late Future<TimeOfDay?> selectedTime;
  String time = "-";

  late int _mmInitialValue = 120;
  late int _hgInitialValue = 85;
  late Box userDataBox;

  String userId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Set the default values for date and time
    userDataBox = Hive.box('userData');
    userId = userDataBox.get("_id", defaultValue: '');
    date = "Today";
    time = TimeUtils.getFormattedTimeSimple(DateTime.now().hour, DateTime.now().minute);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380.0,
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
                        'Update your ${widget.vitalSignText}',
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
                padding: const EdgeInsets.all(5.0),
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
                padding: const EdgeInsets.all(5.0),
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
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${widget.vitalSignText}',
                  style: StyleUtils.bottomSheetTextStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${widget.vitalSignMeasurementText}',
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
                value: _mmInitialValue,
                onChanged: (value) => setState(() => _mmInitialValue = value),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.0),
                    bottom: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(width: 10.0,),
              NumberPicker(
                minValue: 10,
                maxValue: 200,
                value: _hgInitialValue,
                onChanged: (value) => setState(() => _hgInitialValue = value),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.0),
                    bottom: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              ),
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
                    backgroundColor: widget.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    // Call API To send data to vital sign database
                    callAPIToSendBloodPressureData();
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
    TimeOfDay initialTime;
    if (time != null) {
      List<String> parts = time.split(' ');
      String amPm = parts[1];
      int hour = int.parse(parts[0].split(':')[0]);
      int minute = int.parse(parts[0].split(':')[1]);
      if (amPm == 'PM' && hour != 12) hour += 12;
      if (amPm == 'AM' && hour == 12) hour = 0;
      initialTime = TimeOfDay(hour: hour, minute: minute);
    } else {
      initialTime = TimeOfDay.now();
    }
    selectedTime = showTimePicker(
      context: context,
      initialTime: initialTime,
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
      });
    }, onError: (error) {
      print(error);
    });
  }

  void callAPIToSendBloodPressureData() {
    Map<String, dynamic> vitalSigns = {};

    vitalSigns['blood_pressure'] = "$_mmInitialValue/$_hgInitialValue";

    // Add date and time
    if (date == "Today") {
      vitalSigns["date"] = DateFormat('MMMM d, yyyy').format(DateTime.now()).toString();
    } else if (date == "Yesterday") {
      vitalSigns["date"] = DateFormat('MMMM d, yyyy').format(DateTime.now().subtract(const Duration(days: 1))).toString();
    } else {
      vitalSigns["date"] = date.toString(); // assuming date is already in 'MMMM d, yyyy' format
    }

    vitalSigns['time'] = time.toString();

    print(userId);
    print(vitalSigns);

    VitalSignsService.addVitalSings(userId, vitalSigns).then((response) => {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message))),
      Navigator.pop(context),
    });
  }
}
