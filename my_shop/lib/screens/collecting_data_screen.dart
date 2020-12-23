import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/screens/auth_screen.dart';
import 'package:my_shop/widgets/collecting_data_widgets/collecting_data_one.dart';
import 'package:my_shop/widgets/collecting_data_widgets/collecting_data_two.dart';
import 'package:page_indicator/page_indicator.dart';

class CollectingDataScreen extends StatefulWidget {
  @override
  _CollectingDataScreenState createState() => _CollectingDataScreenState();
}

class _CollectingDataScreenState extends State<CollectingDataScreen> {
  PageController controller;
  File image;
  String userName, mobileNumber;
  int index;
  @override
  void initState() {
    super.initState();
    index = 0;
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void nextPage(File image, String userName, String mobileNumber) {
    setState(() {
      this.image = image;
      this.userName = userName;
      this.mobileNumber = mobileNumber;
      index++;
    });

    controller.nextPage(
        duration: Duration(seconds: 1), curve: Curves.decelerate);
  }

  void prevPage() {
    setState(() {
      index--;
    });
    controller.previousPage(
        duration: Duration(seconds: 1), curve: Curves.decelerate);
  }

  Future<bool> logout() async {
    return await showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Are you sure?'),
        content: Text(
            'If you logged out you will be asked the same questions the next time you login.'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel'),
          ),
          RaisedButton(
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await logout()) {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
        }
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics:
              (index == 1) ? NeverScrollableScrollPhysics() : ScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: PageIndicatorContainer(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1 / 2 + 16),
              length: 2,
              indicatorSelectorColor: Colors.black,
              indicatorColor: Colors.grey,
              shape: IndicatorShape.roundRectangleShape(
                size: Size(20, 5),
                cornerSize: Size.square(20),
              ),
              child: PageView(
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  CollectingDataOne(nextPage),
                  CollectingDataTwo(prevPage),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
