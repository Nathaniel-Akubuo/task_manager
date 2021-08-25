import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/services/user_service.dart';

class TasksProvider extends ChangeNotifier {

  void addToDo({required BuildContext context, required TaskModel taskModel}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var homeUndone =
        FirebaseFirestore.instance.collection('$userEmail-tasks-undone');
    var doc = homeUndone.doc();
    taskModel.id = doc.id;
    doc.set(taskModel.toJson());
  }

  toggleDone({context, required TaskModel taskModel}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var homeUndone =
        FirebaseFirestore.instance.collection('$userEmail-tasks-undone');
    var homeDone =
        FirebaseFirestore.instance.collection('$userEmail-tasks-done');
    if (taskModel.isChecked) {
      taskModel.isChecked = false;
      deleteDone(id: taskModel.id, context: context);
      homeUndone.doc(taskModel.id).set(taskModel.toJson());
    } else if (!taskModel.isChecked) {
      deleteUndone(id: taskModel.id, context: context);
      taskModel.isChecked = true;
      homeDone.doc(taskModel.id).set(taskModel.toJson());
    }
  }

  deleteUndone({context, id}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var homeUndone =
        FirebaseFirestore.instance.collection('$userEmail-tasks-undone');
    return homeUndone.doc(id).delete();
  }

  deleteDone({context, id}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var homeDone =
        FirebaseFirestore.instance.collection('$userEmail-tasks-done');
    homeDone.doc(id).delete();
  }
}
