import 'package:flutter/material.dart';
import 'package:pharma_trac/Analytics/year_picker_graph.dart';
import '../Utils/styleUtils.dart';
import 'graph_sample_year_wise.dart';

class TopNavigationBar extends StatefulWidget {

  final String keyValueVitalSign;

  const TopNavigationBar({super.key, required this.keyValueVitalSign});

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
            'Graph Visualization',
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
          const Center(
            child: Text("It's daily here"),
          ),
          const Center(
            child: Text("It's weekly here"),
          ),
          const Center(
            child: Text("It's monthly here"),
          ),
          YearPickerGraph(vitalSignTitle: widget.keyValueVitalSign)
        ]),
      ),
    );
  }
}
