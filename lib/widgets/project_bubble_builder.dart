import 'package:flutter/material.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/widgets/project_bubble.dart';

class ProjectBubbleBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return  Container(
      height: _mediaQuery.height * 0.225,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ProjectBubble(
          onTap: () {},
          percentage: 40,
          title: 'TRIP',
          color: teal,
          firstItem: 'Holiday in Norway',
          date: '',
        ),
        itemCount: 3,
      ),
    );
  }
}
