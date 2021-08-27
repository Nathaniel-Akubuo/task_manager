import 'package:flutter/material.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';

class ProjectToDoBubble extends StatelessWidget {
  final String title;
  final isChecked;
  final onChecked;
  final onDismissed;
  final VoidCallback onTap;

  ProjectToDoBubble(
      {required this.title,
      required this.isChecked,
      this.onChecked,
      this.onDismissed,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Dismissible(
        onDismissed: onDismissed,
        key: UniqueKey(),
        background: Container(color: grey),
        child: Column(
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    shape: CircleBorder(),
                    checkColor: backgroundColor,
                    activeColor: darkGrey,
                    value: isChecked,
                    onChanged: onChecked,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                    child: Text(title,
                        style: isChecked
                            ? kTaskStyle.copyWith(
                                color: darkGrey,
                                decoration: TextDecoration.lineThrough)
                            : kTaskStyle),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55, right: 10),
              child: Divider(
                color: darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
