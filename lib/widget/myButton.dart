import 'package:flutter/material.dart';
import 'package:sampleproject/Theme/Themes.dart';

class myButton extends StatelessWidget {
  String title;
  var myfunc;
  double padding;
  double height;
  var color;
  myButton(
      {required this.title,
      required this.myfunc,
      required this.height,
      required this.padding,
      this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(padding),
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              color == null ? Colors.teal : color as Color),
        ),
        onPressed: myfunc,
        child: Text(
          '${title}',
          style: Themes().headLine3.copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
