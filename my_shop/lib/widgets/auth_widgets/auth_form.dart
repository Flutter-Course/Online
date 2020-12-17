import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/screens/home_screen.dart';
import 'package:my_shop/widgets/auth_widgets/auth_title.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  final Function toggleResetPassword;
  AuthForm(this.toggleResetPassword);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  GlobalKey field;
  GlobalKey<FormState> form;
  bool hidePassword, hideConfirmPassword, loginMode, loading;
  double height;
  String email, password, confirmPassword;
  FocusNode passwordNode, confirmPasswordNode;

  @override
  void initState() {
    super.initState();
    field = GlobalKey();
    form = GlobalKey<FormState>();
    passwordNode = FocusNode();
    confirmPasswordNode = FocusNode();
    loading = false;
    hideConfirmPassword = hidePassword = loginMode = true;
    height = 0;
  }

  void tryToRegister() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });
      String error = await Provider.of<UserProvider>(context, listen: false)
          .register(email, password);
      if (error == null) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } else {
        setState(() {
          loading = false;
        });
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(error), backgroundColor: Colors.redAccent));
      }
    }
  }

  void tryToLogin() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });
      String error = await Provider.of<UserProvider>(context, listen: false)
          .login(email, password);
      if (error == null) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } else {
        setState(() {
          loading = false;
        });
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(error), backgroundColor: Colors.redAccent));
      }
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
                child: (loginMode)
                    ? AuthTitle(UniqueKey(), 'Login into')
                    : AuthTitle(UniqueKey(), 'Create'),
              ),
              Form(
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      key: field,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        setState(() {
                          email = value;
                        });
                        if (EmailValidator.validate(value)) {
                          return null;
                        }

                        return 'Invalid email address';
                      },
                      onFieldSubmitted: (value) {
                        passwordNode.requestFocus();
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
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      focusNode: passwordNode,
                      obscureText: hidePassword,
                      textInputAction: (loginMode)
                          ? TextInputAction.done
                          : TextInputAction.next,
                      onFieldSubmitted: (value) {
                        if (!loginMode) {
                          confirmPasswordNode.requestFocus();
                        }
                      },
                      validator: (value) {
                        setState(() {
                          password = value;
                        });
                        if (value.length >= 6) {
                          return null;
                        }
                        return 'Password must contains 6 characters at least';
                      },
                      decoration: InputDecoration(
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          child: Icon(
                            (hidePassword)
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                          ),
                        ),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                        ),
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
                        labelText: 'Password',
                        hintText: '••••••••',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.bounceOut,
                      height: height,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 400),
                        opacity: (loginMode) ? 0 : 1,
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          obscureText: hideConfirmPassword,
                          focusNode: confirmPasswordNode,
                          validator: (value) {
                            setState(() {
                              confirmPassword = value;
                            });

                            if (value == password || loginMode) {
                              return null;
                            }

                            return 'Passwords must match';
                          },
                          decoration: InputDecoration(
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  hideConfirmPassword = !hideConfirmPassword;
                                });
                              },
                              child: Icon(
                                (hideConfirmPassword)
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                              ),
                            ),
                            errorStyle: TextStyle(
                              color: Colors.redAccent,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 3,
                              ),
                            ),
                            labelText: 'Confirm Password',
                            hintText: '••••••••',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    widget.toggleResetPassword();
                  },
                ),
              ),
              (loading)
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      margin: EdgeInsets.only(top: 10),
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 400),
                          child: (loginMode)
                              ? Text(
                                  'Login',
                                  key: UniqueKey(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Register',
                                  key: UniqueKey(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        color: Colors.black,
                        onPressed: () {
                          if (loginMode) {
                            tryToLogin();
                          } else {
                            tryToRegister();
                          }
                        },
                      ),
                    ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: (loginMode)
                    ? FlatButton(
                        key: UniqueKey(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                        onPressed: () {
                          final c = field.currentContext;
                          final box = c.findRenderObject() as RenderBox;
                          setState(() {
                            height = box.size.height;
                            loginMode = !loginMode;
                          });
                        },
                      )
                    : FlatButton(
                        key: UniqueKey(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            height = 0;
                            loginMode = !loginMode;
                          });
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
