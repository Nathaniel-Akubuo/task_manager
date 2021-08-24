import 'package:flutter/material.dart';
import 'package:task_manager/constants/colors.dart';

class RoundedButton extends StatelessWidget {
  final Widget child;
  final color;
  final onTap;

  RoundedButton({this.onTap, this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: mediaQuery.width * 0.025,
              vertical: mediaQuery.height * 0.012),
          height: 50,
          decoration: BoxDecoration(
              color: color ?? blue, borderRadius: BorderRadius.circular(10)),
          child: child),
    );
  }
}
