import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/services/util.dart';

class ColorSelectionContainer extends StatefulWidget {
  @override
  _ColorSelectionContainerState createState() =>
      _ColorSelectionContainerState();
}

class _ColorSelectionContainerState extends State<ColorSelectionContainer> {
  var blueVal = false;

  var tealVal = false;

  var orangeVal = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      width: 120,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  Provider.of<Util>(context, listen: false).pickedColor = blue;
                  blueVal = !blueVal;
                  tealVal = false;
                  orangeVal = false;
                });
              },
              child: Transform.scale(
                scale: blueVal ? 1.3 : 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: blue, borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
          ),
          horizontalSpaceSmall,
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  orangeVal = !orangeVal;
                  Provider.of<Util>(context, listen: false).pickedColor =
                      orange;
                  tealVal = false;
                  blueVal = false;
                });
              },
              child: Transform.scale(
                scale: orangeVal ? 1.3 : 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: orange, borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
          ),
          horizontalSpaceSmall,
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  tealVal = !tealVal;
                  Provider.of<Util>(context, listen: false).pickedColor = teal;
                  blueVal = false;
                  orangeVal = false;
                });
              },
              child: Transform.scale(
                scale: tealVal ? 1.3 : 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: teal, borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
