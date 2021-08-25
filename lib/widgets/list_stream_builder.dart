import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/services/tasks_provider.dart';
import 'package:task_manager/widgets/to_do_bubble.dart';

// ignore: must_be_immutable
class UndoneListBuilder extends StatelessWidget {
  final stream;
  final isDoneList;

  UndoneListBuilder({this.stream, this.isDoneList});

  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<TasksProvider>(context, listen: false);
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.data != null && snapshot.data!.size != 0) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var currentItem = snapshot.data!.docs[index].data();
              return ToDoBubble(
                  title: currentItem['item'],
                  onChecked: (_) => tasks.toggleDone(
                      context: context,
                      taskModel: TaskModel.fromJson(currentItem)),
                  isChecked: currentItem['isChecked'],
                  onDismissed: (_) => isDoneList
                      ? tasks.deleteDone(
                          context: context, id: currentItem['id'])
                      : tasks.deleteUndone(
                          context: context, id: currentItem['id']),
                  onTap: () {},
                  isDone: currentItem['isChecked']);
            },
          );
        } else
          return Container();
      },
    );
  }
}
