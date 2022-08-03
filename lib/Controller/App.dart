import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class App extends GetxController {
  List<String> getListQuiz = [
    'ads',
  ];
  var docIDs = [];
  List<String> idUser = [];
  Future getDoc() async {
    await FirebaseFirestore.instance
        .collection('/quiz/desc/details')
        .get()
        .then((value) => value.docs.forEach((element) {
              var a = docIDs.any((a) => a == element.reference.id);
              print('================= $a');
              if (a == false) {
                docIDs.add(element.reference.id);
              }
            }));
  }

  Future getDeleteItem(var id) async {
    await FirebaseFirestore.instance
        .collection('/quiz/desc/details/')
        .doc('${id}')
        .delete()
        .then((value) async {
      for (int i = 0; i < 4; i++) {
        var a1 = await FirebaseFirestore.instance
            .collection('/quiz/quesions/details')
            .doc('${int.parse(id) + i}')
            .delete();
      }
      docIDs = [];
      print('deleted');
      getDoc();
    });
  }

  Future refreshItem() async {
    docIDs = [];
    await getDoc();
    print('refreshed');
  }

  Future FetchData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) => value.docs.forEach((val) async {
              var a = idUser.any((element) => element == val.reference.id);
              if (a == false) {
                idUser.add(val.reference.id);
              }
            }));
  }

  Future printDataItems(var id) async {
    await getDoc();
    await FetchData();
    for (int i = 0; i < idUser.length; i++) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('${idUser[i]}')
          .collection('${id}')
          .add({
        'id': '${id}',
        'fetchData': false,
      });
    }
  }

  Future newUsersItems(var userId) async {
    await getDoc();
    await FetchData();
    if (docIDs.isEmpty) {
      print('is data empty');
    } else {
      for (int i = 0; i < docIDs.length; i++) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('${userId}')
            .collection('${docIDs[i]}')
            .add({
          'id': '${docIDs[i]}',
          'fetchData': false,
        });
      }
    }
  }

  var getque = {
    '0': [
      {
        'que': '',
        '0': '',
        '1': '',
        '2': '',
        '3': '',
        'answer': '',
      }
    ],
    '1': [
      {
        'que': '',
        '0': '',
        '1': '',
        '2': '',
        '3': '',
        'answer': '',
      }
    ],
    '2': [
      {
        'que': '',
        '0': '',
        '1': '',
        '2': '',
        '3': '',
        'answer': '',
      }
    ],
    '3': [
      {
        'que': '',
        '0': '',
        '1': '',
        '2': '',
        '3': '',
        'answer': '',
      }
    ],
  };
  int i = 0;
  // Future getInf(int quizId) async {
  //   await FirebaseFirestore.instance
  //       .collection('/quiz/quesions/details')
  //       .get()
  //       .then((value) => value.docs.forEach((element) {
  //             if (element == null) {
  //               getque['$i']![0]['que'] = '';
  //               getque['$i']![0]['0'] = '';
  //               getque['$i']![0]['1'] = '';
  //               getque['$i']![0]['2'] = '';
  //               getque['$i']![0]['3'] = '';
  //               getque['$i']![0]['answer'] = '';
  //               print('==========${getque['0']![0]['0']}');
  //               i++;
  //             }
  //             if (element['id'] == quizId) {
  //               getque['$i']![0]['que'] = element['que'];
  //               getque['$i']![0]['0'] = element['a'];
  //               getque['$i']![0]['1'] = element['b'];
  //               getque['$i']![0]['2'] = element['c'];
  //               getque['$i']![0]['3'] = element['d'];
  //               getque['$i']![0]['answer'] = element['answer'];
  //               print('==========${getque['0']![0]['0']}');
  //               i++;
  //             }
  //           }));
  // }
}
