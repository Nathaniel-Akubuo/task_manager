import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/models/project_model.dart';
import 'package:task_manager/services/util.dart';
import 'package:task_manager/widgets/project_bubble.dart';

class ProjectBubbleBuilder extends StatelessWidget {
  final stream;

  ProjectBubbleBuilder(this.stream);

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    var util = Provider.of<Util>(context, listen: false);
    return Container(
      height: _mediaQuery.height * 0.225,
      child: StreamBuilder(
        stream: stream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.data != null && snapshot.data!.size != 0) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                ProjectModel currentItem =
                    ProjectModel.fromJson(snapshot.data!.docs[index].data());
                return ProjectBubble(
                    onTap: () {
                      util.title = currentItem.title;
                      util.id = currentItem.id;
                      util.color = currentItem.color;
                      return navigationService.navigateTo(Routes.projects);
                    },
                    percentage: currentItem.count,
                    title: currentItem.title,
                    color: currentItem.color,
                    date: currentItem.dateCreated.toString());
              },
              itemCount: snapshot.data!.docs.length,
            );
          } else
            return Container();
        },
      ),
    );
  }
}
