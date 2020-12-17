import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
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
}
