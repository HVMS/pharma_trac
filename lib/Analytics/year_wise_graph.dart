import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class YearWiseGraph extends StatefulWidget {

  final List<ChartData> data;
  final String vitalSignText;
  const YearWiseGraph({super.key, required this.data, required this.vitalSignText});

  @override
  State<YearWiseGraph> createState() => _YearWiseGraph();
}

class _YearWiseGraph extends State<YearWiseGraph> {
  late List<ChartData> data = [];
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = widget.data;
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 300, interval: 50),
        tooltipBehavior: _tooltip,
        series: <ChartSeries<ChartData, String>>[
      BarSeries<ChartData, String>(
          dataSource: data,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          pointColorMapper: (ChartData data, _) => data.color,
          name: widget.vitalSignText,
          color: const Color.fromRGBO(8, 142, 255, 1))
    ]);
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
