import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class WeekPickerGraph extends StatefulWidget {
  final String vitalSignTitle;
  const WeekPickerGraph({Key? key, required this.vitalSignTitle}) : super(key: key);

  @override
  State<WeekPickerGraph> createState() => _WeekPickerGraphState();
}

class _WeekPickerGraphState extends State<WeekPickerGraph> {
  DateTime currentDate = DateTime.now();
  late Box userDataBox;
  String userId = '';

  @override
  void initState() {
    super.initState();
    userDataBox = Hive.box('userData');
    userId = userDataBox.get("_id", defaultValue: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  selectPreviousWeek();
                },
              ),
              Text(
                formattedDate(currentDate),
                style: const TextStyle(fontSize: 20.0),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: canSelectNextWeek() ? selectNextWeek : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool canSelectNextWeek() {
    final currentWeek = DateTime.now().difference(currentDate).inDays ~/ 7;
    return currentWeek > 0;
  }

  String formattedDate(DateTime date) {
    final weekStart = date.subtract(Duration(days: date.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));
    return "${DateFormat.MMMM().format(weekStart)} ${weekStart.day} - ${DateFormat.MMMM().format(weekEnd)} ${weekEnd.day}, ${date.year}";
  }

  void selectNextWeek() {
    setState(() {
      currentDate = currentDate.add(const Duration(days: 7));
    });
  }

  void selectPreviousWeek() {
    setState(() {
      currentDate = currentDate.subtract(const Duration(days: 7));
    });
  }
}
