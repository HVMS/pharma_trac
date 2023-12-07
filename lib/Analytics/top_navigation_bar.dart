import 'package:flutter/material.dart';
import '../Utils/styleUtils.dart';

class TopNavigationBar extends StatefulWidget {
  const TopNavigationBar({super.key});

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
      ),
    );
  }
}