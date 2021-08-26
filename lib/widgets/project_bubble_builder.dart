import 'package:flutter/material.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/widgets/project_bubble.dart';

class ProjectBubbleBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: _mediaQuery.height * 0.225,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          ProjectBubble(
            onTap: () {},
            percentage: 80,
            title: 'MEETINGS',
            color: orange,
            firstItem: "Amanda at Ruth's",
            date: 'TODAY',
          ),
          ProjectBubble(
            onTap: () {},
            percentage: 40,
            title: 'TRIP',
            color: teal,
            firstItem: 'Holiday in Norway',
            date: 'SAT',
          ),
          ProjectBubble(
            onTap: () {},
            percentage: 70,
            title: 'INBOX',
            color: blue,
            firstItem: 'Read online reviews',
            date: '',
          ),
          ProjectBubble(
            onTap: () {},
            percentage: 70,
            title: 'INBOX',
            color: darkGrey,
            firstItem: 'Read online reviews',
            date: '',
          ),
          ProjectBubble(
            onTap: () {},
            percentage: 70,
            title: 'INBOX',
            color: Colors.indigo[300],
            firstItem: 'Read online reviews',
            date: '',
          ),
          ProjectBubble(
            onTap: () {},
            percentage: 70,
            title: 'INBOX',
            color: Colors.white,
            firstItem: 'Read online reviews',
            date: '',
          ),
        ],
      ),
    );
  }
}
