import 'package:flutter/material.dart';
import 'package:task_manager/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final hintText;

  CustomTextField({required this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    final maxLines = 5;
    final mediaQuery = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Theme(
      data: ThemeData(primaryColor: blue),
      child: Container(
        margin: EdgeInsets.all(12),
        width: mediaQuery.width * 0.8,
        height: mediaQuery.height * 0.08,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: TextField(
          controller: controller,
          autofocus: true,
          style: theme.textTheme.subtitle2,
          maxLines: maxLines,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding: EdgeInsets.all(10)),
        ),
      ),
    );
  }
}
