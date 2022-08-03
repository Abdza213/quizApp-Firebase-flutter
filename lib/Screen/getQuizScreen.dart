import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Controller/App.dart';
import 'package:sampleproject/Screen/quizScreen.dart';
import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/main.dart';

import 'package:sampleproject/widget/Skeletondart.dart';

class getQuizScreen extends StatefulWidget {
  var documentId;
  getQuizScreen({required this.documentId});

  @override
  State<getQuizScreen> createState() => _getQuizScreenState();
}

class _getQuizScreenState extends State<getQuizScreen> {
  App s1 = Get.find();

  String? id = pref.getString('key');

  @override
  Widget build(BuildContext context) {
    var inf = FirebaseFirestore.instance.collection('/quiz/desc/details');
    return FutureBuilder<DocumentSnapshot>(
      future: inf.doc('${widget.documentId}').get(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 5,
              margin: EdgeInsets.only(left: 15, right: 15, top: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                // width: 500,
                // color: Colors.red,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(
                      width: 5,
                    ),

                    ///
                    ////
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Skeleton(
                          height: 25,
                          width: 180,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Skeleton(
                          height: 60,
                          width: 180,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }

        var a = snapshot.data!.data();
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              //  /users/RW29e4cR6JM2IAXRTWMFf9XHNNy2/fetch/3907
              .collection('/users/$id/${widget.documentId}/')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<DocumentSnapshot> s1 = snapshot.data!.docs;

            return !s1.isEmpty
                ? Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedOpacity(
                          opacity:
                              (s1 as dynamic)[0]['fetchData'] == false ? 1 : .5,
                          duration: Duration(microseconds: 300),
                          child: FutureBuilder(
                            builder: ((context, snapshot) {
                              return GestureDetector(
                                onTap: () {
                                  (s1 as dynamic)[0]['fetchData'] == false
                                      ? Get.off(
                                          () => quizScreen(
                                              quizId: (a as dynamic)['id']),
                                        )
                                      : print('Completed');
                                },
                                child: Card(
                                  elevation: 5,
                                  margin: EdgeInsets.only(
                                      left: 15, right: 15, top: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    // height: 300,
                                    // color: Colors.red,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if ((a as dynamic)['quizType'] != null)
                                          Container(
                                            // color: Colors.red,
                                            child: SvgPicture.asset(
                                              (a as dynamic)['quizType'] ==
                                                      'Maths'
                                                  ? 'images/math.svg'
                                                  : (a as dynamic)[
                                                              'quizType'] ==
                                                          'Chemistry'
                                                      ? 'images/chemistry.svg'
                                                      : (a as dynamic)[
                                                                  'quizType'] ==
                                                              'Biology'
                                                          ? 'images/biology.svg'
                                                          : 'images/physic.svg',
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8.2,
                                              color: Colors.black45,
                                            ),
                                          ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${(a as dynamic)['quizType']}',
                                              style:
                                                  Themes().headLine3.copyWith(
                                                        color: Colors.teal[700],
                                                      ),
                                            ),
                                            Container(
                                              width: 180,
                                              // height: 200, color: Colors.red,
                                              // color: Colors.red,
                                              // color: Colors.red,
                                              child: Text(
                                                '${(a as dynamic)['shortExp']}',
                                                style:
                                                    Themes().headLine2.copyWith(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.question,
                                                  color: Colors.teal,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('4 quizzes'),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        if ((s1 as dynamic)[0]['fetchData'] == true)
                          Container(
                            height: 60,
                            width: 200,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.teal[100],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 50,
                                ),
                                Text(
                                  'Completed',
                                  style: Themes()
                                      .headLine3
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  )
                : Center(
                    child: Text('is empty'),
                  );
          },
        ); /* FutureBuilder(
          builder: ((context, snapshot) {
            return GestureDetector(
              onTap: () {
                Get.off(
                  () => quizScreen(quizId: (a as dynamic)['id']),
                );
              },
              child: Card(
                elevation: 5,
                margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  // height: 300,
                  // color: Colors.red,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if ((a as dynamic)['quizType'] != null)
                        Container(
                          // color: Colors.red,
                          child: SvgPicture.asset(
                            (a as dynamic)['quizType'] == 'Maths'
                                ? 'images/math.svg'
                                : (a as dynamic)['quizType'] == 'Chemistry'
                                    ? 'images/chemistry.svg'
                                    : (a as dynamic)['quizType'] == 'Biology'
                                        ? 'images/biology.svg'
                                        : 'images/physic.svg',
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 8.2,
                            color: Colors.black45,
                          ),
                        ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${(a as dynamic)['quizType']}',
                            style: Themes().headLine3.copyWith(
                                  color: Colors.teal[700],
                                ),
                          ),
                          Container(
                            width: 180,
                            // height: 200, color: Colors.red,
                            // color: Colors.red,
                            // color: Colors.red,
                            child: Text(
                              '${(a as dynamic)['shortExp']}',
                              style: Themes().headLine2.copyWith(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                FontAwesomeIcons.question,
                                color: Colors.teal,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('4 quizzes'),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ); */
      }),
    );
  }
}
