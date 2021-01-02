import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class User {
  String email, userId, username, address, phoneNumber;
  LatLng position;

  User.fromFirebase(this.userId, doc)
      : email = doc['email'],
        username = doc['username'],
        address = doc['address'],
        phoneNumber = doc['phoneNumber'],
        position = LatLng(doc['lat'], doc['lng']);

  User.fromUser(User user)
      : this.userId = user.userId,
        this.username = user.username,
        this.address = user.address,
        this.email = user.email,
        this.phoneNumber = user.phoneNumber,
        this.position = user.position;

  Future<void> init();
}
