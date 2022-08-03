import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Controller/App.dart';
import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/Screen/getQuizScreen.dart';
import 'package:sampleproject/Screen/quizScreen.dart';

class getquizScreen extends StatefulWidget {
  @override
  State<getquizScreen> createState() => _getquizScreenState();
}

class _getquizScreenState extends State<getquizScreen> {
  App s1 = Get.find();
  @override
  void initState() {
    s1.getDoc();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        s1.docIDs.length,
        (index) => SizedBox(
          // width: 700,
          child: getQuizScreen(
            documentId: s1.docIDs[index],
          ),
        ),
      ),
    );
  }
}
/* GestureDetector(
          onTap: () {
            Get.off(() => startQuiz());
          },
          child: Card(
            elevation: 5,
            margin: EdgeInsets.only(left: 15, right: 15, top: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
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
                      'images/chemistry.svg',
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
                        'Physic',
                        style: Themes().headLine3.copyWith(
                              color: Colors.teal[700],
                            ),
                      ),
                      Container(
                        width: 220,
                        child: Text(
                          'ath  to practice basic math quiz',
                          style: Themes().headLine2.copyWith(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
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
        ), */
