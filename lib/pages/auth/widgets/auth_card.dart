import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:lancer/helpers/responsiveness.dart';
import 'package:lancer/pages/home_page.dart';
import 'package:lancer/services/firebase_auth.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  bool _passHidden = true;
  bool _confpassHidden = true;

  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  var _isLoadingGoogle = false;
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _emailController = TextEditingController();

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Future<void> _submit() async {
      if (!_formKey.currentState!.validate()) {
        // Invalid!
        return;
      }
      _formKey.currentState?.save();
      setState(() {
        _isLoading = true;
      });
      if (_authMode == AuthMode.Login) {
        // Log user in
        var signintemp = await FirebaseAuthApp().userSignin(
            _authData["email"] ?? "no email",
            _authData["password"] ?? "no pass");
        if (signintemp["success"]) {
          //load the data
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
          _emailController.clear();
          _passwordController.clear();
          _confirmpasswordController.clear();
        } else {
          Fluttertoast.showToast(
            msg: _emailController.text.isEmpty
                ? "Email is required"
                : _passwordController.text.isEmpty
                    ? "Password is required"
                    : signintemp["msg"]
                            .toString()
                            .contains("password is invalid")
                        ? "Password inccorect"
                        : signintemp["msg"]
                                .toString()
                                .contains("no user record")
                            ? "User not found!"
                            : "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15,
          );
          _emailController.clear();
          _passwordController.clear();
          _confirmpasswordController.clear();
        }
      } else {
        // Sign user up
        if (_passwordController.text == _confirmpasswordController.text &&
            (_passwordController.text.isNotEmpty) &&
            (_confirmpasswordController.text.isNotEmpty)) {
          var signuptemp = await FirebaseAuthApp().userSignup(
              _authData["email"] ?? "no email",
              _authData["password"] ?? "no pass");
          if (signuptemp["success"]) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
            _emailController.clear();
            _passwordController.clear();
            _confirmpasswordController.clear();
          } else {
            Fluttertoast.showToast(
              msg: signuptemp["msg"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 15,
            );
            _emailController.clear();
            _passwordController.clear();
            _confirmpasswordController.clear();
          }
        } else {
          Fluttertoast.showToast(
            msg: _emailController.text.isEmpty
                ? "Email is required"
                : _passwordController.text.isEmpty
                    ? "Password is required"
                    : !(_passwordController.text ==
                            _confirmpasswordController.text)
                        ? "Password does not match"
                        : "somehting went wrong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15,
          );
        }
      }
      setState(() {
        _isLoading = false;
      });
    }

    return Container(
      height: _authMode == AuthMode.Signup ? 500 : 420,
      constraints:
          BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
      width: deviceSize.width *
          (Responsivness().isSmall(context)
              ? 0.9
              : Responsivness().isMedium(context)
                  ? 0.6
                  : 0.4),
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(340),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35.0,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    autocorrect: false,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "E-mail",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      _authData['email'] = value ?? "no email";
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(340),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35.0,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          autocorrect: false,
                          decoration: const InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          obscureText: _passHidden,
                          controller: _passwordController,
                          onSaved: (value) {
                            _authData['password'] = value ?? "no pass";
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _passHidden = !_passHidden;
                            });
                          },
                          icon: Icon(
                            _passHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 20,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
              ),
              if (_authMode == AuthMode.Signup)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(340),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35.0,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                autocorrect: false,
                                controller: _confirmpasswordController,
                                enabled: _authMode == AuthMode.Signup,
                                decoration: const InputDecoration(
                                  hintText: "Confirm password",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                obscureText: _confpassHidden,
                                validator: _authMode == AuthMode.Signup
                                    ? (value) {
                                        if (value != _passwordController.text) {
                                          Fluttertoast.showToast(
                                            msg: "Password does not match",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 15,
                                          );
                                        }
                                      }
                                    : null,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _confpassHidden = !_confpassHidden;
                                  });
                                },
                                icon: Icon(
                                  _confpassHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 20,
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 50,
              ),
              if (_isLoading)
                const CupertinoActivityIndicator()
              else
                GestureDetector(
                  onTap: _submit,
                  child: Container(
                    width: deviceSize.width * 0.8,
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      color: Colors.brown.shade200,
                    ),
                    child: Center(
                        child: Text(
                      _authMode == AuthMode.Login ? 'Login' : 'Sign up',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )),
                  ),
                ),
              const SizedBox(height: 15),
              if (_isLoadingGoogle)
                const CupertinoActivityIndicator()
              else
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLoadingGoogle = true;
                    });
                    FirebaseAuthApp().signInwithGoogle().then((value) {
                      setState(() {
                        _isLoadingGoogle = false;
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    }).onError((error, stackTrace) {
                      setState(() {
                        _isLoadingGoogle = false;
                      });
                    });
                  },
                  child: Container(
                    width: deviceSize.width * 0.8,
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      color: Colors.brown.withOpacity(0.3),
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage("assets/google_logo.png"),
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Signin with google',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text(
                        _authMode == AuthMode.Login
                            ? 'Create a account?'
                            : 'Already have a account?',
                        style: TextStyle(
                          color: Colors.brown.shade200,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: _switchAuthMode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: constant_identifier_names
