import 'package:Chat_App/services/auth.dart';
import 'package:Chat_App/views/SignIn.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/SignUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _usernameFocus = FocusNode();
  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _usernameFocus.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool isLoading = false;
  AuthMethods authMethods = AuthMethods();

  signMeUp() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods
          .signInWithEmailAndPassword(_email.text, _password.text)
          .then((val) {
        print(val);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.maxFinite,
                  height: 400,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty || value.length < 4) {
                                  return 'Provide username';
                                } else {
                                  return null;
                                }
                              },
                              controller: _username,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  hintText: 'Username',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10)),
                              focusNode: _usernameFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                _usernameFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_emailFocus);
                              },
                            ),
                            TextFormField(
                              validator: (value) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        .hasMatch(value)
                                    ? null
                                    : 'Provide valid email';
                              },
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10)),
                              focusNode: _emailFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                _emailFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocus);
                              },
                            ),
                            TextFormField(
                              controller: _password,
                              validator: (value) {
                                return value.length > 6
                                    ? null
                                    : 'Password should be longer than 6 letters';
                              },
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10)),
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              focusNode: _passwordFocus,
                              /* onFieldSubmitted: (_) {
                        _passwordFocus.unfocus();
                        FocusScope.of(context).requestFocus(_f);
                      } */
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: RaisedButton(
                            color: Colors.lightGreenAccent[50],
                            child: Text('Sign up'),
                            onPressed: () {
                              signMeUp();
                            },
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: RaisedButton(
                            color: Colors.lightBlue[50],
                            child: Text('Sign up with google'),
                            onPressed: () {
                              print('hi');
                            },
                          ),
                        ),
                      ),
                      Container(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(fontSize: 17),
                              ),
                              TextSpan(
                                  text: 'Click here',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .popAndPushNamed(SignIn.routeName);
                                    }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
