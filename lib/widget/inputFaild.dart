import 'package:flutter/material.dart';
import 'package:sampleproject/Theme/Themes.dart';

class inputFaild extends StatelessWidget {
  TextEditingController? textEditingController;
  int? maxLength;
  int? maxLines;
  String? title;
  String hintText;
  Widget? suffixIcon;
  inputFaild({
    this.maxLength,
    this.maxLines,
    this.title,
    this.textEditingController,
    required this.hintText,
    this.suffixIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Text(
                  '${title}',
                  style: Themes().headLine3.copyWith(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width / (16.6),
                      ),
                )
              : SizedBox(
                  height: 0,
                ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            readOnly: suffixIcon == null ? false : true,
            controller: textEditingController,
            maxLength: maxLength,
            maxLines: maxLines,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(),
              hintText: '${hintText}',
              hintStyle: TextStyle(
                color: Colors.black45,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 0, 112, 123),
                ),
              ),
            ),
            onSaved: (val) {
              textEditingController!.text = val as String;
              print('${textEditingController!.text}');
            },
          ),
        ],
      ),
    );
  }
}
