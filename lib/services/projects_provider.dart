import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/project_model.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/services/user_service.dart';
import 'package:task_manager/services/util.dart';

class ProjectsProvider extends ChangeNotifier {
  void createProject({context, required ProjectModel projectModel}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var projects = FirebaseFirestore.instance.collection('$userEmail-projects');
    var doc = projects.doc();
    projectModel.id = doc.id;
    doc.set(projectModel.toJson());
  }

  void addToDo({context, required TaskModel taskModel}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var util = Provider.of<Util>(context, listen: false);
    var projects = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(util.id)
        .collection('${util.title}-undone');
    var doc = projects.doc();
    taskModel.id = doc.id;
    doc.set(taskModel.toJson());
  }

  toggleDone({context, required TaskModel taskModel}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var util = Provider.of<Util>(context, listen: false);

    var projectUndone = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(util.id)
        .collection('${util.title}-undone');
    var projectDone = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(util.id)
        .collection('${util.title}-done');
    if (taskModel.isChecked) {
      taskModel.isChecked = false;
      deleteDone(id: taskModel.id, context: context);
      projectUndone.doc(taskModel.id).set(taskModel.toJson());
    } else if (!taskModel.isChecked) {
      deleteUndone(id: taskModel.id, context: context);
      taskModel.isChecked = true;
      projectDone.doc(taskModel.id).set(taskModel.toJson());
    }
  }

  deleteUndone({context, id}) {
    var util = Provider.of<Util>(context, listen: false);
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var projectUndone = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(util.id)
        .collection('${util.title}-undone');
    projectUndone.doc(id).delete();
  }

  void deleteDone({context, id}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var util = Provider.of<Util>(context, listen: false);
    var projectDone = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(util.id)
        .collection('${util.title}-done');
    projectDone.doc(id).delete();
  }
}
