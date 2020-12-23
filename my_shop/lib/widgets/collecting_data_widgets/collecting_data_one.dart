import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_shop/widgets/collecting_data_widgets/collecting_data_title.dart';
import 'package:my_shop/widgets/collecting_data_widgets/image_frame.dart';
import 'package:my_shop/widgets/misc/arrow_button.dart';

class CollectingDataOne extends StatefulWidget {
  final Function nextPage;
  CollectingDataOne(this.nextPage);
  @override
  _CollectingDataOneState createState() => _CollectingDataOneState();
}

class _CollectingDataOneState extends State<CollectingDataOne> {
  File image;
  String userName, mobileNumber;

  void pickImage(bool fromGallery) async {
    ImagePicker picker = ImagePicker();
    final pickedImage = await picker.getImage(
        source: (fromGallery) ? ImageSource.gallery : ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  bool validData() {
    return image != null &&
        userName != null &&
        userName.length >= 3 &&
        mobileNumber != null &&
        mobileNumber.length == 11 &&
        mobileNumber.startsWith('01');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 32,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  CollectingDataTitle(
                      'Few steps left to complete your profile.'),
                  ImageFrame.fromFile(image),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton.icon(
                        color: Colors.black,
                        icon: Icon(Icons.camera_alt, color: Colors.white),
                        label: Text(
                          'Camera',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          pickImage(false);
                        },
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      RaisedButton.icon(
                        color: Colors.black,
                        icon: Icon(Icons.photo_library, color: Colors.white),
                        label: Text(
                          'Gallery',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          pickImage(true);
                        },
                      ),
                    ],
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        userName = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: 'Ex. Muhammed Aly',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        )),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        mobileNumber = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      hintText: 'Ex. 01xxxxxxxxx',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ArrowButton.left(label: 'Logout', onPressed: () {}),
                  ArrowButton.right(
                    label: 'Next',
                    onPressed: () {
                      if (validData()) {
                        widget.nextPage(image, userName, mobileNumber);
                      } else {
                        showDialog(
                          context: context,
                          child: AlertDialog(
                            title: Text('Invalid Data'),
                            content: Text(
                              'Make sure that you picked an image, entered a username consists of at least 3 characters and entered a valid mobile number',
                            ),
                            actions: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Ok'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
