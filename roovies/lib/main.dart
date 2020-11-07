import 'package:flutter/material.dart';
import 'package:roovies/helpers/constants.dart';
import 'package:roovies/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roovies',
      theme: ThemeData(
        primarySwatch: Constants.color,
        accentColor: Color.fromRGBO(244, 193, 15, 1),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Constants.color,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.grey[600],
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
