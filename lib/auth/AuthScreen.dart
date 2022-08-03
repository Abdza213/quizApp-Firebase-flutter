// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sampleproject/Firebase/auth.dart';

import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/Screen/homePageSceen.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/widget/myButton.dart';

class AuthScreen extends StatefulWidget {
  AuthMode authMode = AuthMode.Login;
  AuthScreen({required this.authMode});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum AuthMode {
  SignUp,
  Login,
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, dynamic> _authData = {
    'userName': TextEditingController(text: ''),
    'email': TextEditingController(text: ''),
    'password': TextEditingController(text: ''),
  };

  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    print('${MediaQuery.of(context).size.height}');
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: 50,
                      // ),
                      Text(
                        widget.authMode != AuthMode.SignUp
                            ? 'Welcome back, '
                            : 'Create account',
                        style: Themes().headLine1.copyWith(
                              fontSize: 32,
                              color: Colors.white,
                            ),
                      ),
                      Text(
                        widget.authMode != AuthMode.SignUp
                            ? 'sign in to continue '
                            : 'sign up to continue ',
                        style: Themes().headLine2.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(15),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              // color: Colors.red,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                constraints: BoxConstraints(
                                    minHeight: widget.authMode == AuthMode.Login
                                        ? 0
                                        : MediaQuery.of(context).size.height /
                                            6.2,
                                    maxHeight: widget.authMode == AuthMode.Login
                                        ? 0
                                        : MediaQuery.of(context).size.height /
                                            6.2),
                                child: SingleChildScrollView(
                                    child: Column(
                                  children: [
                                    getForm(
                                      label: 'User name',
                                      textEditingController:
                                          _authData['userName'],
                                      icon: FontAwesomeIcons.user,
                                      validator: (val) {
                                        if (val!.isEmpty &&
                                            widget.authMode ==
                                                AuthMode.SignUp) {
                                          return 'invaild user name';
                                        }
                                      },
                                    ),
                                  ],
                                )),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0,
                                  -(MediaQuery.of(context).size.height / 72)),
                              child: getForm(
                                label: 'Email address',
                                textEditingController: _authData['email'],
                                icon: Icons.email,
                                validator: (val) {
                                  if (val!.isEmpty || !val.contains('@')) {
                                    return 'invaild email';
                                  }
                                },
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0,
                                  -(MediaQuery.of(context).size.height / 35)),
                              child: getForm(
                                label: 'Password',
                                textEditingController: _authData['password'],
                                icon: Icons.lock,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'invaild password';
                                  } else if (val.length < 6) {
                                    return 'short password';
                                  }
                                },
                                sufficIcon: IconButton(
                                  icon: Icon(
                                    showPass == false
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showPass = !showPass;
                                    });
                                  },
                                ),
                                showPass: showPass,
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0, -10),
                              child: isLoading == false
                                  ? Column(
                                      children: [
                                        myButton(
                                          title:
                                              widget.authMode != AuthMode.SignUp
                                                  ? 'Login'
                                                  : 'SIGN UP',
                                          myfunc: _submit,
                                          height: 50,
                                          padding: 0,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(widget.authMode ==
                                                    AuthMode.SignUp
                                                ? 'already have a account ?!  '
                                                : 'Don\'t have account ?!  '),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (widget.authMode ==
                                                      AuthMode.Login) {
                                                    widget.authMode =
                                                        AuthMode.SignUp;
                                                  } else {
                                                    widget.authMode =
                                                        AuthMode.Login;
                                                  }
                                                });
                                              },
                                              child: Text(
                                                widget.authMode ==
                                                        AuthMode.SignUp
                                                    ? 'Login'
                                                    : 'create account now',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.teal,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationThickness: 2,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getForm({
    required String label,
    required IconData icon,
    required TextEditingController textEditingController,
    var validator,
    var sufficIcon,
    var showPass,
  }) {
    return Container(
      height: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${label}',
            style: Themes().headLine1.copyWith(
                  fontSize: 20,
                  color: Colors.black,
                ),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: textEditingController,
            obscureText: showPass == null
                ? false
                : showPass == false
                    ? false
                    : true,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: Colors.black54,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintText: '${label}',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintStyle: TextStyle(
                  color: Colors.black45,
                ),
                suffixIcon: sufficIcon),
            validator: validator,
            onSaved: (val) {
              textEditingController.text = val as String;
            },
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      return;
    } else {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
    }
    print('email : ${_authData['email'].text}');
    print('password :${_authData['password'].text}');
    print('user : ${_authData['userName'].text}');
    print('${widget.authMode}');

    setState(() {
      isLoading = true;
    });
    try {
      if (widget.authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'].text as String,
          _authData['password'].text as String,
        );
        var x = Provider.of<Auth>(context, listen: false).addNewUser;
        print('================== ${x[0].Id}');
        pref.setString('key', '${x[0].Id}');
        pref.setBool('fetch', true);
        Get.off(() => homePageScreen());
      } else {
        await Provider.of<Auth>(context, listen: false).signUp(
          _authData['email'].text as String,
          _authData['password'].text as String,
        );
        var x = Provider.of<Auth>(context, listen: false).addNewUser;
        newAccountCreated(
          id: '${x[0].Id}',
          userName: _authData['userName'].text as String,
          email: _authData['email'].text as String,
          password: _authData['password'].text as String,
        );
        Get.off(() => homePageScreen());
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      var errorMessage = 'Authenticatio Faild';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      getSnackBar(errorMessage);
    }
  }

  bool isLoading = false;
  getSnackBar(String title) {
    Get.snackbar(
      'Wrong entry',
      '$title',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.teal[800],
      colorText: Colors.white,
      icon: Icon(Icons.error),
      margin: EdgeInsets.all(15),
    );
  }
}
