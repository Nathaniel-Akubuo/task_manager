import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide ReorderableList;
import 'package:provider/provider.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/services/projects_provider.dart';
import 'package:task_manager/widgets/project_to_do_bubble.dart';

class ProjectListStreamBuilder extends StatelessWidget {
  final stream;
  final isDoneList;

  ProjectListStreamBuilder({this.stream, this.isDoneList});

  @override
  Widget build(BuildContext context) {
    var projects = Provider.of<ProjectsProvider>(context, listen: false);
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.data != null && snapshot.data!.size != 0) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              TaskModel currentItem =
                  TaskModel.fromJson(snapshot.data!.docs[index].data());
              return ProjectToDoBubble(
                  title: currentItem.item,
                  isChecked: currentItem.isChecked,
                  onDismissed: (_) => isDoneList
                      ? projects.deleteDone(
                          context: context, id: currentItem.id)
                      : projects.deleteUndone(
                          context: context, id: currentItem.id),
                  onChecked: (_) => projects.toggleDone(
                      taskModel: currentItem, context: context),
                  onTap: () {});
            },
          );
        } else
          return Container();
      },
    );
  }
}
