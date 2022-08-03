import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/auth/AuthScreen.dart';
import 'package:sampleproject/widget/myButton.dart';

class startScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4.2,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'images/Gears-01.svg',
                      color: Colors.teal,
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  Text(
                    'Welcome',
                    style: Themes().headLine3.copyWith(
                          fontSize: 40,
                          color: Colors.black,
                        ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                      'Are you ready to learn cultural things easily and the funniest way?',
                      style: Themes().headLine3.copyWith(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  myButton(
                    title: 'Get Started',
                    myfunc: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: AuthScreen(
                            authMode: AuthMode.SignUp,
                          ),
                          type: PageTransitionType.bottomToTop,
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                    },
                    height: MediaQuery.of(context).size.height / 15,
                    padding: 0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Already have an account ?!',
                          style: Themes()
                              .headLine1
                              .copyWith(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                child: AuthScreen(
                                  authMode: AuthMode.Login,
                                ),
                                type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 300),
                              ),
                            );
                          }),
                          child: Text(
                            'Log in',
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
