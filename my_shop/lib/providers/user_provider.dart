import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_shop/models/user.dart' as myShop;
import 'package:my_shop/models/customer.dart';
import 'package:my_shop/models/vendor.dart';

class UserProvider with ChangeNotifier {
  myShop.User currentUser;

  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Invalid email or password';
        case 'invalid-email':
          return 'Invalid email or password';
        default:
          return 'This user has been disabled';
      }
    } on SocketException {
      return 'Network problem try again later';
    }
  }

  Future<String> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'This email is already in use';
        case 'invalid-email':
          return 'Invalid email address';
        default:
          return 'You entered a weak password';
      }
    } on SocketException {
      return 'Network problem try again later';
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      return 'Check your internect connecting and that your email is valid';
    }
  }

  Future<bool> completeProfile(
    File image,
    String username,
    String address,
    String phoneNumber,
    LatLng position,
  ) async {
    try {
      final userId = FirebaseAuth.instance.currentUser.uid;
      final email = FirebaseAuth.instance.currentUser.email;
      final ref = FirebaseStorage.instance
          .ref('users/$userId.${image.path.split('.').last}');
      await ref.putFile(image);
      final imageUrl = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'username': username,
        'address': address,
        'phoneNumber': phoneNumber,
        'lat': position.latitude,
        'lng': position.longitude,
        'email': email,
        'imageUrl': imageUrl,
        'type': 'Customer',
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isCompleteProfile() async {
    try {
      final userId = FirebaseAuth.instance.currentUser.uid;
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (doc.exists) {
        if (doc.data()['type'] == 'Customer') {
          currentUser = Customer.fromFirebase(userId, doc);
        } else {
          currentUser = Vendor.fromFirebase(userId, doc);
        }

        await currentUser.init();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> switchAccountType() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.userId)
          .update({
        'type': isCustomer ? 'Vendor' : 'Customer',
      });

      if (isCustomer) {
        currentUser = Vendor.fromCustomer(currentUser);
      } else {
        currentUser = Customer.fromVendor(currentUser);
      }

      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool get isCustomer {
    return currentUser is Customer;
  }
}
