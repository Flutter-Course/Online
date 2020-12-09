import 'package:flutter/material.dart';
import 'package:my_shop/widgets/auth_widgets/auth_background.dart';
import 'package:my_shop/widgets/auth_widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AuthBackground(),
          AuthForm(),
        ],
      ),
    );
  }
}
