import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sampleproject/Controller/App.dart';
import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/Screen/homePageSceen.dart';
import 'package:sampleproject/Screen/resultQuizScreen.dart';

class quizScreen extends StatefulWidget {
  int quizId;

  quizScreen({required this.quizId});

  @override
  State<quizScreen> createState() => _quizScreenState();
}

class _quizScreenState extends State<quizScreen> {
  App s1 = Get.find();

  @override
  void initState() {
    // s1.getInf(widget.quizId);

    super.initState();
  }

  var groub = [0, 0, 0, 0];
  var queIndex = 0;
  List<bool> rightQue = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Q${queIndex + 1}'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('/quiz/quesions/details')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          int b = 0;
          List<DocumentSnapshot> s2 = snapshot.data!.docs;
          for (int i = 0; i < s2.length; i++) {
            if ((s2 as dynamic)[i]['id'] == widget.quizId) {
              s1.getque['$b']![0]['que'] = (s2 as dynamic)[i]['que'];

              s1.getque['$b']![0]['0'] = (s2 as dynamic)[i]['0'];
              s1.getque['$b']![0]['1'] = (s2 as dynamic)[i]['1'];
              s1.getque['$b']![0]['2'] = (s2 as dynamic)[i]['2'];
              s1.getque['$b']![0]['3'] = (s2 as dynamic)[i]['3'];
              s1.getque['$b']![0]['answer'] = (s2 as dynamic)[i]['answer'];

              b++;
            }
          }
          // print('${s1.getque['0']![0]['que']}');
          return !s2.isEmpty
              ? Center(
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              getQue(
                                que:
                                    s1.getque['$queIndex']![0]['que'] as String,
                                answer: s1.getque['$queIndex']![0],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      theBottomPage(
                        q1: s1.getque['0']![0]['answer'] as String,
                        q2: s1.getque['1']![0]['answer'] as String,
                        q3: s1.getque['2']![0]['answer'] as String,
                        q4: s1.getque['3']![0]['answer'] as String,
                      )
                    ],
                  ),
                )
              : Text('');
        },
      ),
    );
  }

  getQue({required String que, var answer}) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            '#${queIndex + 1} Question',
            style: Themes().headLine3.copyWith(
                  fontSize: 25,
                  color: Colors.black,
                ),
            // textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          // alignment: Alignment.center,

          // color: Colors.red,

          child: Text(
            '${que}',
            style: Themes().headLine1.copyWith(
                  fontSize: 20,
                  color: Colors.black,
                ),
            // textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        for (int i = 0; i < 4; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                groub[queIndex] = i;
                print('${groub[queIndex]}');
              });
            },
            child: Card(
              elevation: 2,
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(10),

                // color: Colors.red,
                decoration: BoxDecoration(
                  color: groub[queIndex] == i ? Colors.teal : Colors.teal[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.s,
                  children: [
                    Radio(
                      activeColor: Colors.black,
                      value: i,
                      groupValue: groub[queIndex],
                      onChanged: (val) {
                        setState(() {
                          groub[queIndex] = val as int;
                          print('============ ${groub[queIndex]}');
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        ' ${answer['$i']}',
                        style: Themes().headLine1.copyWith(
                              fontSize: 17,
                              color: groub[queIndex] == i
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  theBottomPage(
      {required String q1,
      required String q2,
      required String q3,
      required String q4}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        queIndex >= 1
            ? Container(
                height: MediaQuery.of(context).size.height / 15,
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      queIndex -= 1;
                      print('===========${queIndex}');
                    });
                  },
                  child: Icon(
                    Icons.navigate_before,
                    color: Colors.white,
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height / 15,
                margin: EdgeInsets.all(20),
              ),
        queIndex < 3
            ? Container(
                height: MediaQuery.of(context).size.height / 15,
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      queIndex += 1;
                      print('===========${queIndex}');
                    });
                  },
                  child: Icon(
                    Icons.navigate_next_sharp,
                    color: Colors.white,
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height / 15,
                alignment: Alignment.center,
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    print('my answers---------------------------------------');
                    print('${groub[0]}');
                    print('${groub[1]}');
                    print('${groub[2]}');
                    print('${groub[3]}');
                    print('Right answer');
                    print('============ $q1');
                    print('============ $q2');
                    print('============ $q3');
                    print('============ $q4');
                    print('-----------------------------');

                    if ('${groub[0]}' == q1) {
                      setState(() {
                        rightQue[0] = true;
                      });
                    } else {
                      setState(() {
                        rightQue[0] = false;
                      });
                    }
                    if ('${groub[1]}' == q2) {
                      setState(() {
                        rightQue[1] = true;
                      });
                    } else {
                      setState(() {
                        rightQue[1] = false;
                      });
                    }
                    if ('${groub[2]}' == q3) {
                      setState(() {
                        rightQue[2] = true;
                      });
                    } else {
                      setState(() {
                        rightQue[2] = false;
                      });
                    }
                    if ('${groub[3]}' == q4) {
                      setState(() {
                        rightQue[3] = true;
                      });
                    } else {
                      setState(() {
                        rightQue[3] = false;
                      });
                    }
                    print('$rightQue');
                    print('0-0------------------------------');
                    Get.off(() => resultQuizScreen(
                          answerQue: rightQue,
                          quizId: widget.quizId,
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Next',
                      style: Themes().headLine3,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
