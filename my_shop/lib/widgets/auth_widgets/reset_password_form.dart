import 'package:flutter/material.dart';
import 'package:my_shop/widgets/auth_widgets/auth_title.dart';

class ResetPasswordForm extends StatefulWidget {
  final Function toggleResetPassword;
  ResetPasswordForm(this.toggleResetPassword);
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: AuthTitle(
                  UniqueKey(),
                  'Reset password of',
                ),
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        labelText: 'Email',
                        hintText: 'example@abc.com',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  shape: StadiumBorder(),
                  color: Colors.black,
                  child: Text(
                    'Reset Password',
                    key: UniqueKey(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              FlatButton(
                onPressed: () {
                  widget.toggleResetPassword();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
