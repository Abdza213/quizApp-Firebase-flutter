import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/admin/adminhomePageSceen.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/widget/myButton.dart';

class adminReferans extends StatefulWidget {
  @override
  State<adminReferans> createState() => _adminReferansState();
}

class _adminReferansState extends State<adminReferans> {
  TextEditingController s1 = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  submit() {
    if (!_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      return;
    } else {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
    }
    adminPref.setBool('fetch', true);
    Get.off(() => adminhomePageSceen());
  }

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
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(35),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
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
                        'Welcome to',
                        style: Themes().headLine3.copyWith(
                              fontSize: 40,
                              color: Colors.black,
                            ),
                      ),
                      Container(
                        // color: Colors.red,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text(
                          'Managers App',
                          style: Themes().headLine3.copyWith(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      getForm(
                          validator: (val) {
                            if (val != 'abdza2003') {
                              return 'Invalid Input ..!';
                            }
                          },
                          label: 'Reference Code',
                          icon: Icons.key,
                          textEditingController: s1),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 150,
                        child: myButton(
                          title: 'Next',
                          myfunc: submit,
                          height: 40,
                          padding: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getForm({
    required String label,
    required IconData icon,
    required TextEditingController textEditingController,
    var validator,
    var sufficIcon,
    var showPass,
  }) {
    return Container(
      height: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${label}',
            style: Themes().headLine1.copyWith(
                  fontSize: 20,
                  color: Colors.black,
                ),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: textEditingController,
            obscureText: showPass == null
                ? false
                : showPass == false
                    ? false
                    : true,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: Colors.black54,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintText: '${label}',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintStyle: TextStyle(
                  color: Colors.black45,
                ),
                suffixIcon: sufficIcon),
            validator: validator,
            onSaved: (val) {
              textEditingController.text = val as String;
            },
          ),
        ],
      ),
    );
  }
}
