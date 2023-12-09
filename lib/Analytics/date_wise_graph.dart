import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DateTimeCategoryLabel extends StatefulWidget {
  final List<BloodPressureData> data;
  final String vitalSignText;
  const DateTimeCategoryLabel(
      {Key? key, required this.data, required this.vitalSignText})
      : super(key: key);

  @override
  State<DateTimeCategoryLabel> createState() => _DateTimeCategoryLabelState();
}

class _DateTimeCategoryLabelState extends State<DateTimeCategoryLabel> {
  TooltipBehavior? _tooltipBehavior;
  List<BloodPressureData> data = [];

  @override
  void initState() {
    data = widget.data;
    _tooltipBehavior = TooltipBehavior(enable: true, header: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
        majorGridLines: const MajorGridLines(width: 0),
        dateFormat: DateFormat('h a'),
        intervalType: DateTimeIntervalType.hours,
        interval: 4, // 6 hours in minutes (60 * 6)
        minimum: DateTime(data[0].year.year, data[0].year.month,
            data[0].year.day, 0,0),
        // set the maximum date as the next date of the first date in data
        maximum: DateTime(data[0].year.year, data[0].year.month,
                data[0].year.day, 0,0)
            .add(const Duration(days: 1)),
      ),
      title: ChartTitle(
        text: 'Blood Pressure Details Date wise',
      ),
      primaryYAxis: NumericAxis(
        majorTickLines: const MajorTickLines(size: 0),
        interval: 40,
        minimum: 0,
        maximum: 200,
        axisLine: const AxisLine(width: 0),
        labelFormat: '{value}',
        title: AxisTitle(
          text: 'Blood Pressure Value',
        ),
      ),
      tooltipBehavior: _tooltipBehavior,
      series: <ColumnSeries<BloodPressureData, DateTime>>[
        ColumnSeries<BloodPressureData, DateTime>(
          dataSource: data!,
          name: 'Systolic',
          xValueMapper: (BloodPressureData x, int xx) => x.year,
          // xValueMapper: (_BloodPressureData x, int xx) => x.year,
          yValueMapper: (BloodPressureData sales, _) =>
              sales.bloodPressure.systolic,
          dataLabelSettings: const DataLabelSettings(
            isVisible: false,
            offset: Offset(0, -5),
          ),
        ),
        ColumnSeries<BloodPressureData, DateTime>(
          dataSource: data!,
          name: 'Diastolic',
          xValueMapper: (BloodPressureData x, int xx) => x.year,
          yValueMapper: (BloodPressureData sales, _) =>
              sales.bloodPressure.diastolic,
          dataLabelSettings: const DataLabelSettings(
            isVisible: false,
            offset: Offset(0, -5),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    data!.clear();
    super.dispose();
  }
}

class BloodPressureData {
  BloodPressureData(this.year, this.bloodPressure);
  final DateTime year;
  // final double sales;
  final BloodPressure bloodPressure;
}

class BloodPressure {
  BloodPressure(this.systolic, this.diastolic);
  final double systolic;
  final double diastolic;
}
