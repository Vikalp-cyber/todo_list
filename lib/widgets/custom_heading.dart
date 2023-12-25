import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_list/utils/textstyle.dart';

class Heading extends StatelessWidget {
  String name;
   Heading(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.only(top: 3.h, bottom: 2.h),
              child: Text(
                "$name",
                style: MyText.MyText3,
              ),
            );
  }
}