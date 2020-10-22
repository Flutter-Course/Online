import 'dart:collection';

import 'package:delivery_manager/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery Manager',
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      home: HomeScreen(),
    );
  }
}
