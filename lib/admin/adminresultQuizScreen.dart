import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Controller/App.dart';
import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/Screen/homePageSceen.dart';
import 'package:sampleproject/admin/adminhomePageSceen.dart';
import 'package:sampleproject/widget/myButton.dart';

class adminresultQuizScreen extends StatefulWidget {
  var answerQue;
  adminresultQuizScreen({required this.answerQue});

  @override
  State<adminresultQuizScreen> createState() => _adminresultQuizScreenState();
}

class _adminresultQuizScreenState extends State<adminresultQuizScreen> {
  var answer = [false, true, false, false];
  var rightQue = {
    '0': '',
    '1': '',
    '2': '',
    '3': '',
  };
  var wrongQue = {
    '0': '',
    '1': '',
    '2': '',
    '3': '',
  };

  @override
  void initState() {
    for (int i = 0; i < widget.answerQue.length; i++) {
      if (widget.answerQue[i] == true) {
        rightQue['$i'] = 'true';
      } else {
        wrongQue['$i'] = 'false';
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Resul Quiz'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Quiz Result',
                style: Themes().headLine3.copyWith(
                      fontSize: 25,
                      color: Colors.black,
                    ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 50,
                  ),
                  Text(
                    'right questions',
                    style: Themes().headLine1.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 4; i++)
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: rightQue['$i'] == 'true'
                            ? Colors.green
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Q${i + 1}',
                        style: TextStyle(
                          color: rightQue['$i'] == 'true'
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.dangerous,
                    color: Colors.red,
                    size: 50,
                  ),
                  Text(
                    'wrong questions',
                    style: Themes().headLine1.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i <= 3; i++)
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: wrongQue['$i'] == 'false'
                            ? Colors.red
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Q${i + 1}',
                        style: TextStyle(
                          color: wrongQue['$i'] == 'true'
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: 120,
                  child: myButton(
                    title: 'Continue',
                    myfunc: () {
                      print('afdasd');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => adminhomePageSceen()),
                          ((route) => false));
                    },
                    height: 50,
                    padding: 0,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
