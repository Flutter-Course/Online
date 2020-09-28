import 'package:flutter/material.dart';

void sayNo() {
  print('No');
}

void main() {
  var textStyle = TextStyle(color: Colors.white, fontSize: 25);
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text('Have You Ever'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'First Question',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RaisedButton(
                child: Text(
                  'Yes',
                  style: textStyle,
                ),
                color: Color.fromRGBO(78, 212, 121, 1),
                onPressed: () {
                  print('Yes');
                },
              ),
              RaisedButton(
                child: Text(
                  'No',
                  style: textStyle,
                ),
                color: Colors.red[900],
                onPressed: sayNo,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
