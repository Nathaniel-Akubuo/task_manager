import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';

class ToDoBubble extends StatelessWidget {
  final String title;
  final isChecked;
  final onChecked;
  final onDismissed;
  final VoidCallback onTap;

  ToDoBubble(
      {required this.title,
      this.isChecked = false,
      required this.onChecked,
      required this.onDismissed,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                      activeColor: Colors.grey[700],
                      checkColor: backgroundColor,
                      value: isChecked,
                      onChanged: onChecked),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(title,
                        style: isChecked
                            ? kTaskStyle.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: darkGrey)
                            : kTaskStyle),
                  ),
                )
              ],
            ),
          ),
        ),
        onDismissed: onDismissed,
      ),
    );
  }
}
