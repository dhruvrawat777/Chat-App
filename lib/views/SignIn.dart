import 'package:Chat_App/models/UserLocal.dart';
import 'package:Chat_App/services/auth.dart';
import 'package:Chat_App/views/SignUp.dart';
import 'package:Chat_App/views/chatRoomsScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  static const routeName = '/';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  var _isLoading = false;
  var errorr = "";

  Future<void> SignIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      AuthMethods authMethods = AuthMethods();
      dynamic result = await authMethods.signInWithEmailAndPassword(
          _email.text, _password.text);
      if (result == null) {
        setState(() {
          _isLoading = false;
          errorr = "Unknown Error";
        });
      } else {
        print("User:" + result.userId);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return ChatRoom();
          },
        ));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
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
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _email,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)),
                        focusNode: _emailFocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          _emailFocus.unfocus();
                          FocusScope.of(context).requestFocus(_passwordFocus);
                        },
                      ),
                      TextFormField(
                        controller: _password,
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
                      GestureDetector(
                        onTap: () {
                          print('tap');
                        },
                        child: Container(
                          //width: double.maxFinite,
                          height: 25,
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          alignment: Alignment.topRight,
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
                            child: Text('Sign in'),
                            onPressed: () {
                              SignIn();
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
                            child: Text('Sign in with google'),
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
                                text: 'Don\'t have an account? ',
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
                                          .popAndPushNamed(SignUp.routeName);
                                    }),
                            ],
                          ),
                        ),
                      ),
                      /*  errorr = ''
                          ? Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(errorr),
                              
                            ))
                          : Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(''),
                            )) */
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
