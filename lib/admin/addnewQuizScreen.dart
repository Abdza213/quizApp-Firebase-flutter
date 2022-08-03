import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Controller/App.dart';
import 'package:sampleproject/Database/ListInf.dart';
import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/Screen/homePageSceen.dart';
import 'package:sampleproject/admin/adminhomePageSceen.dart';
import 'package:sampleproject/widget/inputFaild.dart';

class addnewQuizScreen extends StatefulWidget {
  @override
  State<addnewQuizScreen> createState() => _addnewQuizScreenState();
}

class _addnewQuizScreenState extends State<addnewQuizScreen> {
  App s1 = Get.find();
  int TopageIndex = 1;
  int peforePgeIndex = 1;
  late PageController _controller = PageController(initialPage: 0);

  List<String> ListQuiz = ['Maths', 'Physic', 'Chemistry', 'Biology'];
  List<String> answers = ['A', 'B', 'C', 'D'];

  Random x = new Random();
  var a;
  @override
  void initState() {
    a = x.nextInt(9999);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Quiz'),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              opacity: isLoading ? .4 : 1,
              duration: Duration(milliseconds: 300),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView(
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (val) {
                      setState(() {
                        TopageIndex = val + 1;
                        peforePgeIndex = TopageIndex - 2;
                      });
                    },
                    controller: _controller,
                    children: [
                      startPage(
                        title: ListInf.controllerMap['4']![0]['title']!,
                        quizType: ListInf.controllerMap['4']![0]['quizType']!,
                        shortExp: ListInf.controllerMap['4']![0]['shortExp']!,
                      ),
                      ...List.generate(
                        4,
                        (index) => quePages(
                          que: ListInf.controllerMap['$index']![0]['que']!,
                          answer: ListInf.controllerMap['$index']![0]
                              ['answer']!,
                          qusNumber: index + 1,
                          a: ListInf.controllerMap['$index']![0]['a']!,
                          b: ListInf.controllerMap['$index']![0]['b']!,
                          c: ListInf.controllerMap['$index']![0]['c']!,
                          d: ListInf.controllerMap['$index']![0]['d']!,
                        ),
                      ),
                    ],
                  ),
                  theBottomPage(),
                ],
              ),
            ),
            if (isLoading == true)
              Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: .6,
                    duration: Duration(milliseconds: 300),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.cyan[800],
                      child: SvgPicture.asset(
                        'images/Gears-01.svg',
                        height: MediaQuery.of(context).size.height / (6.2),
                        width: MediaQuery.of(context).size.width / (6.2),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CircularProgressIndicator(
                    color: Colors.cyan[700],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  theBottomPage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TopageIndex > 1
            ? Container(
                height: MediaQuery.of(context).size.height / 15,
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _controller.animateToPage(peforePgeIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
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
        TopageIndex <= 4
            ? Container(
                height: MediaQuery.of(context).size.height / 15,
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _controller.animateToPage(TopageIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
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
                  onPressed: submit,
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

  quePages({
    required TextEditingController que,
    required TextEditingController answer,
    required TextEditingController a,
    required TextEditingController b,
    required TextEditingController c,
    required TextEditingController d,
    required int qusNumber,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputFaild(
              textEditingController: que,
              title: '#${qusNumber} Question',
              hintText: 'Enter ${qusNumber}. question here .',
              maxLines: 2,
              maxLength: 100,
            ),
            Text(
              'Answers',
              style: Themes().headLine3.copyWith(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width / (16.6),
                  ),
            ),
            FaildAnswers(answer: a, char: 'a'),
            FaildAnswers(answer: b, char: 'b'),
            FaildAnswers(answer: c, char: 'c'),
            FaildAnswers(answer: d, char: 'd'),
            Row(
              children: [
                Text(
                  'The answer is -: ',
                  style: Themes().headLine3.copyWith(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width / (16.6),
                      ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 15, left: 15),
                  color: Colors.teal[100],
                  child: Row(
                    children: [
                      Text('${answer.text}',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      DropdownButton(
                        items: answers
                            .map(
                              (val) => DropdownMenuItem(
                                child: Text('${val}'),
                                value: val,
                              ),
                            )
                            .toList(),
                        onChanged: (String? val) {
                          setState(() {
                            answer.text = val as String;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FaildAnswers({
    required TextEditingController answer,
    required String char,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            '${char}.',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 35,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 9,
          width: MediaQuery.of(context).size.width / 1.4,
          child: inputFaild(
            textEditingController: answer,
            hintText: 'Enter answers here .',
          ),
        ),
      ],
    );
  }

  startPage({
    required TextEditingController title,
    required TextEditingController quizType,
    required TextEditingController shortExp,
  }) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputFaild(
              textEditingController: title,
              title: 'Title',
              hintText: 'add title here .',
              maxLength: 20,
            ),
            SizedBox(
              height: 20,
            ),
            inputFaild(
              title: 'quiz type',
              hintText: '${quizType.text}',
              suffixIcon: Container(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: DropdownButton(
                  items: ListQuiz.map(
                    (val) => DropdownMenuItem(
                      child: Text('${val}'),
                      value: val,
                    ),
                  ).toList(),
                  onChanged: (String? val) {
                    setState(() {
                      quizType.text = val as String;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            inputFaild(
              textEditingController: shortExp,
              title: 'short explanation',
              hintText: 'add short explanation here .',
              maxLines: 3,
              maxLength: 60,
            ),
          ],
        ),
      ),
    );
  }

  bool isLoading = false;
  submit() async {
    if (ListInf.controllerMap['0']![0]['a']!.text == '' ||
        ListInf.controllerMap['0']![0]['b']!.text == '' ||
        ListInf.controllerMap['0']![0]['c']!.text == '' ||
        ListInf.controllerMap['0']![0]['d']!.text == '' ||
        ListInf.controllerMap['0']![0]['que']!.text == '' ||
        ListInf.controllerMap['1']![0]['a']!.text == '' ||
        ListInf.controllerMap['1']![0]['b']!.text == '' ||
        ListInf.controllerMap['1']![0]['c']!.text == '' ||
        ListInf.controllerMap['1']![0]['d']!.text == '' ||
        ListInf.controllerMap['1']![0]['que']!.text == '' ||
        ListInf.controllerMap['2']![0]['a']!.text == '' ||
        ListInf.controllerMap['2']![0]['b']!.text == '' ||
        ListInf.controllerMap['2']![0]['c']!.text == '' ||
        ListInf.controllerMap['2']![0]['d']!.text == '' ||
        ListInf.controllerMap['2']![0]['que']!.text == '' ||
        ListInf.controllerMap['3']![0]['a']!.text == '' ||
        ListInf.controllerMap['3']![0]['b']!.text == '' ||
        ListInf.controllerMap['3']![0]['c']!.text == '' ||
        ListInf.controllerMap['3']![0]['d']!.text == '' ||
        ListInf.controllerMap['3']![0]['que']!.text == '' ||
        ListInf.controllerMap['4']![0]['title']!.text == '' ||
        ListInf.controllerMap['4']![0]['shortExp']!.text == '') {
      getSnackBar('Please fill in all the data');
    } else {
      setState(() {
        isLoading = true;
      });
      print('afdfgsdfg');
      await FirebaseFirestore.instance
          .collection('quiz')
          .doc('desc')
          .collection('details')
          .doc('$a')
          .set({
        'id': a,
        'title': ListInf.controllerMap['4']![0]['title']!.text,
        'shortExp': ListInf.controllerMap['4']![0]['shortExp']!.text,
        'quizType': ListInf.controllerMap['4']![0]['quizType']!.text
      });
      geInf(int index) {
        return ListInf.controllerMap['$index']![0]['answer']!.text;
      }

      for (int i = 0; i < 4; i++) {
        await FirebaseFirestore.instance
            .collection('quiz')
            .doc('quesions')
            .collection('details')
            .doc('${a + i}')
            .set({
          'id': a,
          'que': ListInf.controllerMap['$i']![0]['que']!.text,
          '0': ListInf.controllerMap['$i']![0]['a']!.text,
          '1': ListInf.controllerMap['$i']![0]['b']!.text,
          '2': ListInf.controllerMap['$i']![0]['c']!.text,
          '3': ListInf.controllerMap['$i']![0]['d']!.text,
          'answer': geInf(i) == 'A'
              ? '0'
              : geInf(i) == 'B'
                  ? '1'
                  : geInf(i) == 'C'
                      ? '2'
                      : '3',
        });
      }
      setState(() {
        isLoading = false;
      });
      //////////////////////
      s1.printDataItems(a);
      ////////
      print('added');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => adminhomePageSceen()),
          ((route) => false));
      // Get.off(() => adminhomePageSceen());
    }
  }

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
