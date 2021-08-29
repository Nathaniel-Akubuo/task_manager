import 'package:flutter/material.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';

class ProjectDrawerBubble extends StatelessWidget {
  final color;
  final title;
  final count;
  final onTap;

  ProjectDrawerBubble({this.color, this.title, this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(color: grey, borderRadius: kBorderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 7.5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15),
                  bottom: Radius.circular(15),
                ),
              ),
            ),
            horizontalSpaceRegular,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: kAgipo,
                ),
                Text(
                  '${count.toStringAsFixed(0)} task(s)',
                  style: kAgipo.copyWith(fontSize: 15, color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
