import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Controller/App.dart';
import 'package:sampleproject/Screen/quizScreen.dart';
import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/admin/adminhomePageSceen.dart';
import 'package:sampleproject/admin/adminquizScreen.dart';

import 'package:sampleproject/widget/Skeletondart.dart';
import 'package:sampleproject/widget/bottomSheatItem.dart';

class admingetQuizScreen extends StatelessWidget {
  var documentId;
  admingetQuizScreen({required this.documentId});
  App s1 = Get.find();

  @override
  Widget build(BuildContext context) {
    var inf = FirebaseFirestore.instance.collection('/quiz/desc/details');
    return FutureBuilder<DocumentSnapshot>(
        future: inf.doc('$documentId').get(),
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
          return FutureBuilder(builder: ((context, snapshot) {
            return GestureDetector(
              onTap: () {
                /*  Get.off(
                  () => adminquizScreen(quizId: (a as dynamic)['id']),
                ); */
                Get.bottomSheet(
                  Container(
                    height: MediaQuery.of(context).size.height / (3.2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(207, 255, 255, 255),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          bottomSheetItem(
                            func: () {
                              Get.off(
                                () => adminquizScreen(
                                    quizId: (a as dynamic)['id']),
                              );
                            },
                            title: 'Show Quiz',
                          ),
                          bottomSheetItem(
                            func: () async {
                              await inf.doc('$documentId').delete();
                              await s1.getDeleteItem(documentId);
                              // s1.docIDs.remove('$documentId');
                              await Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          adminhomePageSceen()),
                                  ((route) => false));
                              // Get.back();
                            },
                            title: 'Delete Quiz',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            // height: 50,
                            width: 200,
                            child: Divider(
                              color: Colors.white,
                              thickness: 2,
                            ),
                          ),
                          bottomSheetItem(
                            func: () {
                              Get.back();
                            },
                            title: 'Cencel',
                          ),
                        ],
                      ),
                    ),
                  ),
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
          }));
        }));
  }
}
