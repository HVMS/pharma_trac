import 'package:flutter/material.dart';
import 'package:pharma_trac/Analytics/month_picker_graph.dart';
import 'package:pharma_trac/Analytics/year_picker_graph.dart';
import '../Utils/styleUtils.dart';
import 'date_picker_graph.dart';

class TopNavigationBar extends StatefulWidget {

  final String vitalSignTitle;

  const TopNavigationBar({super.key, required this.vitalSignTitle});

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.vitalSignTitle} Graph',
            style: StyleUtils.appBarTextStyle(),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                child: Text('Daily'),
              ),
              Tab(
                child: Text('Weekly'),
              ),
              Tab(
                child: Text('Monthly'),
              ),
              Tab(
                child: Text('Yearly'),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          DatePickerGraph(vitalSignTitle: widget.vitalSignTitle),
          const Center(
            child: Text("It's weekly here"),
          ),
          MonthPickerGraph(vitalSignTitle: widget.vitalSignTitle),
          YearPickerGraph(vitalSignTitle: widget.vitalSignTitle)
        ]),
      ),
    );
  }
}
