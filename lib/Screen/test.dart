import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/main.dart';

class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var id = pref.getString('key');
    return Scaffold(
      backgroundColor: Colors.cyan[300],
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            //  /users/RW29e4cR6JM2IAXRTWMFf9XHNNy2/fetch/3907
            .collection('/users/RW29e4cR6JM2IAXRTWMFf9XHNNy2/8114/')
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
                  child: Container(
                    height: 300,
                    width: 300,
                    child: Text('${(s1 as dynamic)[0]['id']}'),
                  ),
                )
              : Center(
                  child: Text('is empty'),
                );
        },
      ),
    );
  }
}
