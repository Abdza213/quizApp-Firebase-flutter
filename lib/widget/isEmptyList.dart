import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sampleproject/Theme/Themes.dart';

class isEmptyList extends StatelessWidget {
  const isEmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      columnCount: 0,
      position: 0,
      child: ScaleAnimation(
        duration: Duration(milliseconds: 1500),
        child: FadeInAnimation(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: RefreshIndicator(
              onRefresh: () async {
                // await FirebaseFirestore.instance
                //     .collection('/newAccount/${idKey}/note')
                //     .snapshots();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'images/lamp.svg',
                      height: 150,
                      width: 150,
                      color: Colors.teal,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      // color: Colors.red,
                      width: 400,
                      child: Text(
                        'no quiz has been added yet .. !!',
                        style: Themes().headLine3.copyWith(
                              fontSize: 18,
                              color: Colors.black.withOpacity(.6),
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
