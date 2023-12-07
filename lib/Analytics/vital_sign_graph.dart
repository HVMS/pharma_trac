import 'package:flutter/material.dart';
import 'package:pharma_trac/customWidgets/Graph/graph_cardview.dart';
import '../Utils/colors_utils.dart';
import '../Utils/styleUtils.dart';

class VitalSignGraphs extends StatefulWidget {
  const VitalSignGraphs({super.key});

  @override
  State<VitalSignGraphs> createState() => _VitalSignGraphsState();
}

class _VitalSignGraphsState extends State<VitalSignGraphs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.appBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Vital Sign Chart',
          style: StyleUtils.appBarTextStyle(),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomGraphCardView(title: 'Blood Pressure'),
              SizedBox(height: 10.0,),
              CustomGraphCardView(title: 'Blood Sugar'),
              SizedBox(height: 10.0,),
              CustomGraphCardView(title: 'Temperature'),
              SizedBox(height: 10.0,),
              CustomGraphCardView(title: 'Blood Cholesterol'),
              SizedBox(height: 10.0,),
              CustomGraphCardView(title: 'Heart Rate'),
            ],
          ),
        ),
      ),
    );
  }
}
