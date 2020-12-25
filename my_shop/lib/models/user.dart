import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  String email, userId, username, address, phoneNumber;
  LatLng position;

  User.fromFirebase(this.userId, doc)
      : email = doc['email'],
        username = doc['username'],
        address = doc['address'],
        phoneNumber = doc['phoneNumber'],
        position = LatLng(doc['lat'], doc['lng']);
}
