import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Viral, How are you?"),
      ),
      body: const Center(
        child: Text("Welcome to the Show!!"),
      ),
    );
  }

}