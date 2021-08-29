import 'package:flutter/material.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';

class AlertDialogBox extends StatelessWidget {
  final content;
  final onPressed;
  final title;

  AlertDialogBox({this.content, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      title: Text(
        title,
        style: kAgipo.copyWith(fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      content: Text(
        content,
        style: kAgipo.copyWith(fontSize: 15),
      ),
      backgroundColor: grey,
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            'OK',
            style: kAgipo.copyWith(fontSize: 15, color: blue, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'CANCEL',
            style: kAgipo.copyWith(fontSize: 15, color: blue, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
