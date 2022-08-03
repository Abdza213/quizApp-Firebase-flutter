import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Controller/App.dart';
import 'package:sampleproject/Firebase/Auth.dart';
import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/admin/addnewQuizScreen.dart';
import 'package:sampleproject/widget/getquizScreen.dart';
import 'package:sampleproject/auth/AuthScreen.dart';
import 'package:sampleproject/auth/startScreen.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/widget/drawer.dart';

class homePageScreen extends StatefulWidget {
  @override
  State<homePageScreen> createState() => _homePageScreenState();
}

class _homePageScreenState extends State<homePageScreen> {
  App s1 = Get.find();

  var top = 0.0;

  var top2 = 400.0;

  var top3 = 0.0;
  @override
  void initState() {
    s1.getDoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.teal[400],
          onPressed: () {
            setState(() {
              s1.refreshItem();
            });
          },
          label: Text("Refresh"),
          icon: Icon(Icons.refresh),
        ),
        drawer: Drawer(
          backgroundColor: Colors.teal,
          child: drawer(),
        ),
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: s1.getDoc(),
          builder: ((context, snapshot) => RefreshIndicator(
                onRefresh: () async {
                  await s1.getDoc();
                },
                child: ListView(
                  // physics: BouncingScrollPhysics(),
                  children: [
                    getQuiz(),
                  ],
                ),
              )),
        ));
  }

  headPage(String fullName) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Hello $fullName 🤞',
                style: Themes().headLine1.copyWith(fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'What do you want to improve today ?!',
            style: Themes().headLine2.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }

  _NotesIsEmpty() {
    return AnimationConfiguration.staggeredGrid(
      columnCount: 0,
      position: 0,
      child: ScaleAnimation(
        duration: Duration(milliseconds: 1500),
        child: FadeInAnimation(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: RefreshIndicator(
              onRefresh: () async {
                // await FirebaseFirestore.instance
                //     .collection('/newAccount/${idKey}/note')
                //     .snapshots();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'images/lamp.svg',
                      height: 150,
                      width: 150,
                      color: Colors.teal,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      // color: Colors.red,
                      width: 400,
                      child: Text(
                        'no quiz has been added yet .. !!',
                        style: Themes().headLine3.copyWith(
                              fontSize: 18,
                              color: Colors.black.withOpacity(.6),
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getQuiz() {
    if (s1.docIDs.isEmpty) {
      return _NotesIsEmpty();
    } else {
      return SizedBox(
        // height: 500,
        // width: 500,
        child: getquizScreen(),
      );
    }
  }
}
