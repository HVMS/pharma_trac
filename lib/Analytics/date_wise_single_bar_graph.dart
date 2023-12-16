import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DateWiseSingleBarGraph extends StatefulWidget {
  final List<VitalSignData> data;
  final String vitalSignText;
  const DateWiseSingleBarGraph(
      {Key? key, required this.data, required this.vitalSignText})
      : super(key: key);

  @override
  State<DateWiseSingleBarGraph> createState() => _DateWiseSingleBarGraphState();
}

class _DateWiseSingleBarGraphState extends State<DateWiseSingleBarGraph> {
  TooltipBehavior? _tooltipBehavior;
  List<VitalSignData> data = [];

  @override
  void initState() {
    print(widget.data);
    data = widget.data;
    _tooltipBehavior = TooltipBehavior(enable: true, header: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enablePanning: true,
        ),
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
        primaryYAxis: NumericAxis(
          majorTickLines: const MajorTickLines(size: 0),
          interval: 40,
          minimum: 0,
          maximum: 200,
          axisLine: const AxisLine(width: 0),
          labelFormat: '{value}',
          title: AxisTitle(
            text: widget.vitalSignText,
          ),
        ),
        tooltipBehavior: _tooltipBehavior,
        series: <ColumnSeries<VitalSignData, DateTime>>[
          ColumnSeries<VitalSignData, DateTime>(
            width: 0.1,
            dataSource: data!,
            xValueMapper: (VitalSignData x, int xx) => x.year,
            // xValueMapper: (_BloodPressureData x, int xx) => x.year,
            yValueMapper: (VitalSignData sales, _) =>
            sales.value,
            dataLabelSettings: const DataLabelSettings(
              isVisible: false,
              offset: Offset(0, -5),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    data!.clear();
    super.dispose();
  }
}

class VitalSignData {
  VitalSignData(this.year, this.value);
  final DateTime year;
  final double value;
}
