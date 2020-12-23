import 'dart:io';

import 'package:flutter/material.dart';

class ImageFrame extends StatelessWidget {
  final File imageFile;
  final String imageUrl;
  ImageFrame.fromFile(this.imageFile) : this.imageUrl = null;
  ImageFrame.fromNetwork(this.imageUrl) : this.imageFile = null;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 80.1,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        radius: 80,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 70,
          child: CircleAvatar(
            radius: 70 - 0.1,
            backgroundColor: Colors.grey,
            backgroundImage: imageFile != null
                ? FileImage(imageFile)
                : (imageUrl != null)
                    ? NetworkImage(imageUrl)
                    : null,
            child: (imageUrl == null && imageFile == null)
                ? Icon(
                    Icons.photo,
                    color: Colors.white,
                    size: 40,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
