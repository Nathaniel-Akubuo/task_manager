import 'package:flutter/material.dart';
import 'package:task_manager/constants/colors.dart';

class ProjectBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(right: 15),
      child: Container(
        height: _mediaQuery.height * 0.225,
        width: 150,
        decoration:
            BoxDecoration(color: grey, borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
