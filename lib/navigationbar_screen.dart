import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NavigationBarScreen extends StatelessWidget {
  const NavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#DFF0FF'),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        height: 60.0,
        backgroundColor: HexColor('#FFFFFF'),
        selectedIndex: currentIndex,
        indicatorColor: HexColor('#579BDA'),
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.analytics),
              label: 'Analytics'
          ),
          NavigationDestination(
              icon: Icon(Icons.add),
              label: 'ADR'
          ),
          NavigationDestination(
              icon: Icon(Icons.chat),
              label: 'Chat'
          ),
          NavigationDestination(
              icon: Icon(Icons.monitor_heart),
              label: 'Vitals'
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Text('Page 1'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 4'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 5'),
        ),
      ][currentIndex],
    );
  }
}
