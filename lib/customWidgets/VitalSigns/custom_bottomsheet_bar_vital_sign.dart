import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pharma_trac/Utils/styleUtils.dart';
import '../../Utils/colors_utils.dart';
import '../../Utils/string_utils.dart';
import '../../Utils/timeUtils.dart';
import '../../services/vital_signs_api.dart';
import '../CustomGreyDivider.dart';

class CustomBottomSheetBarVitalSigns extends StatefulWidget {
  final String? vitalSignText;
  final Color? buttonColor;
  final String? vitalSignMeasurementText;

  const CustomBottomSheetBarVitalSigns(
      {super.key,
      required this.vitalSignText,
      required this.buttonColor,
      this.vitalSignMeasurementText});

  @override
  State<CustomBottomSheetBarVitalSigns> createState() =>
      _CustomBottomSheetBarVitalSignsState();
}

class _CustomBottomSheetBarVitalSignsState
    extends State<CustomBottomSheetBarVitalSigns> {
  late Future<DateTime?> selectedDate;
  String date = "-";

  String dateToBeSent = "-";

  late Future<TimeOfDay?> selectedTime;
  String time = "-";

  late int _vitalSignMeasurementValue = 120;
  late Box userDataBox;

  String userId = '';

  @override
  void initState() {
    super.initState();
    // Set the default values for date and time
    userDataBox = Hive.box('userData');
    userId = userDataBox.get("_id", defaultValue: '');
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
                  '${widget.vitalSignText}',
                  style: StyleUtils.bottomSheetTextStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
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
                value: _vitalSignMeasurementValue,
                onChanged: (value) => setState(() => _vitalSignMeasurementValue = value),
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

    if (widget.vitalSignText == "Blood Sugar"){
      vitalSigns['blood_sugar'] = _vitalSignMeasurementValue.toString();
    } else if (widget.vitalSignText == "Heart Rate"){
      vitalSigns['heart_rate'] = _vitalSignMeasurementValue.toString();
    } else if (widget.vitalSignText == "Blood Cholesterol"){
      vitalSigns['blood_cholesterol'] = _vitalSignMeasurementValue.toString();
    } else if (widget.vitalSignText == "Temperature"){
      vitalSigns['temperature'] = _vitalSignMeasurementValue.toString();
    }

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
