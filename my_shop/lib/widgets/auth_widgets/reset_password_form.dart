import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/widgets/auth_widgets/auth_title.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ResetPasswordForm extends StatefulWidget {
  final Function toggleResetPassword;
  ResetPasswordForm(this.toggleResetPassword);
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  String email;
  GlobalKey<FormState> form;
  bool loading;
  @override
  void initState() {
    super.initState();
    loading = false;
    form = GlobalKey<FormState>();
  }

  void tryToResetPassword() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });
      String error = await Provider.of<UserProvider>(context, listen: false)
          .resetPassword(email);

      if (error == null) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Email has been sent'),
          backgroundColor: Colors.green[900],
        ));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(error),
          backgroundColor: Colors.red[900],
        ));
      }
      setState(() {
        loading = false;
      });
    }
  }

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
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      validator: (value) {
                        setState(() {
                          email = value;
                        });
                        if (EmailValidator.validate(email)) {
                          return null;
                        }
                        return 'Invalid email address';
                      },
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
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                          ),
                        ),
                        labelText: 'Email',
                        hintText: 'example@abc.com',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              (loading)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
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
                        onPressed: () {
                          tryToResetPassword();
                        },
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
