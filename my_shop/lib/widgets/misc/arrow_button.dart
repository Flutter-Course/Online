import 'package:flutter/material.dart';

class ArrowButton extends RaisedButton {
  ArrowButton.left({@required String label, @required Function onPressed})
      : super(
          padding: EdgeInsets.only(left: 15),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          color: Colors.black,
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
  ArrowButton.right({@required String label, @required Function onPressed})
      : super(
          padding: EdgeInsets.only(right: 15),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          color: Colors.black,
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
}
