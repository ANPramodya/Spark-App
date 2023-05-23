import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';

class CustomAlertBox2 extends StatefulWidget {
  final String title;
  final String content;
  final String leftBtn;
  final String rightBtn;
  final VoidCallback leftBtnClick;
  final VoidCallback rightBtnClick;

  const CustomAlertBox2(
      {super.key,
      required this.title,
      required this.content,
      required this.leftBtn,
      required this.rightBtn,
      required this.leftBtnClick,
      required this.rightBtnClick});
  @override
  State<CustomAlertBox2> createState() => _CustomAlertBox2State();
}

class _CustomAlertBox2State extends State<CustomAlertBox2> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.content),
      actions: [
        TextButton(onPressed: widget.leftBtnClick, child: Text(widget.leftBtn)),
        TextButton(
            onPressed: widget.rightBtnClick, child: Text(widget.rightBtn))
      ],
    );
  }
}

//Implementation

// showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return CustomAlertBox2(
//                         title: 'options',
//                         content:
//                             'list of options goes here like crazy ducks. all here can be read by the user',
//                         leftBtn: 'Ok',
//                         rightBtn: 'Cancel',
//                         leftBtnClick: () {},
//                         rightBtnClick: () {
//                           Navigator.of(context).pop();
//                         });
//                   });
