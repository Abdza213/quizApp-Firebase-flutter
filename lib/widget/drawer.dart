import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/auth/AuthScreen.dart';
import 'package:sampleproject/main.dart';

class drawer extends StatefulWidget {
  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  bool isLoading = false;
  String? idKey = pref.getString('key');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc('$idKey')
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var s1 = snapshot.data!.data();

              return Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: (() {}),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          isLoading == false
                              ? Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.black,
                                      //   (a as dynamic)['quizType']
                                      child: (s1 as dynamic)['image_url'] != ''
                                          ? Stack(
                                              alignment: Alignment.bottomLeft,
                                              children: [
                                                ClipOval(
                                                  child: CachedNetworkImage(
                                                    height: 110,
                                                    width: 110,
                                                    fit: BoxFit.cover,
                                                    imageUrl: (s1 as dynamic)[
                                                        'image_url'],
                                                    placeholder:
                                                        (context, url) => Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        AnimatedOpacity(
                                                          duration:
                                                              Duration.zero,
                                                          opacity: .5,
                                                          child:
                                                              SvgPicture.asset(
                                                            'images/Gears-01.svg',
                                                            width: 60,
                                                            height: 60,
                                                          ),
                                                        ),
                                                        CircularProgressIndicator(
                                                          color:
                                                              Colors.cyan[700],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Transform.translate(
                                                  offset: Offset(-10, 5),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      alignment:
                                                          Alignment.center,
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .white38),
                                                    ),
                                                    onPressed: () {
                                                      changeImage();
                                                    },
                                                    child: Transform.translate(
                                                      offset: Offset(0, 0),
                                                      child: Container(
                                                        height: 25,
                                                        width: 25,
                                                        child: Icon(
                                                          Icons.edit,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Stack(
                                              alignment: Alignment.bottomLeft,
                                              children: [
                                                CircleAvatar(
                                                  radius: 55,
                                                  backgroundColor: Colors.white,
                                                  child: AnimatedOpacity(
                                                    duration: Duration.zero,
                                                    opacity: .5,
                                                    child: Icon(
                                                      FontAwesomeIcons.user,
                                                      size: 60,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Transform.translate(
                                                  offset: Offset(-10, 5),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      alignment:
                                                          Alignment.center,
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .white38),
                                                    ),
                                                    onPressed: () {
                                                      changeImage();
                                                    },
                                                    child: Transform.translate(
                                                      offset: Offset(0, 0),
                                                      child: Container(
                                                        height: 25,
                                                        width: 25,
                                                        child: Icon(
                                                          Icons.edit,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ],
                                )
                              : Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 55,
                                      backgroundColor: Colors.white,
                                      child: AnimatedOpacity(
                                        duration: Duration.zero,
                                        opacity: .5,
                                        child: Icon(
                                          FontAwesomeIcons.user,
                                          size: 60,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${(s1 as dynamic)['userName']}',
                            style: Themes().headLine3,
                          ),
                          Text(
                            '${(s1 as dynamic)['email']}',
                            style: Themes().headLine3,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(
            width: 250,
            child: Divider(
              color: Colors.black,
              thickness: 1.2,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          getCardInf(context, 'Home Page'.tr, Icons.home, () {
            Get.back();
          }),
          SizedBox(
            height: 10,
          ),
          getCardInf(context, 'Log Out'.tr, Icons.logout, () async {
            await pref.clear();
            Get.off(
              () => AuthScreen(authMode: AuthMode.Login),
            );
          }),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  changeImage() async {
    final ImagePicker _picker = ImagePicker();
    File? pickedImage;

    final image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    if (image == null) {
      return;
    }

    setState(() {
      isLoading = true;

      pickedImage = File(image.path);
    });
    Random x = Random();

    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child('$idKey${x.nextInt(100)}.jpg');

    ///
    ////
    var urlImage;
    if (pickedImage != null) {
      await ref.putFile(pickedImage!);
      urlImage = await ref.getDownloadURL();
      await ref.putFile(pickedImage!);
    } else {
      urlImage =
          'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png';
    }
    await FirebaseFirestore.instance.collection('users').doc('$idKey').update({
      'image_url': urlImage,
    });
    setState(() {
      isLoading = false;
    });
  }
}

Widget getCardInf(
    BuildContext context, String label, IconData icon, void addFunc()) {
  return InkWell(
    onTap: (() {
      addFunc();
    }),
    child: Card(
      color: Colors.white,
      child: ListTile(
        leading: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            // fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    ),
  );
}
