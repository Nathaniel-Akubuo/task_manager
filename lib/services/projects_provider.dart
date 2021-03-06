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
    var id = Provider.of<Util>(context, listen: false).id;
    var projects = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(id)
        .collection('$id-undone');

    var doc = projects.doc();
    taskModel.id = doc.id;
    doc.set(taskModel.toJson());
    updateCountAndFirstItem(context);
  }

  void toggleDone({context, required TaskModel taskModel}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var id = Provider.of<Util>(context, listen: false).id;

    var projectUndone = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(id)
        .collection('$id-undone');
    var projectDone = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(id)
        .collection('$id-done');
    if (taskModel.isChecked) {
      taskModel.isChecked = false;
      deleteDone(docID: taskModel.id, context: context);
      projectUndone.doc(taskModel.id).set(taskModel.toJson());
    } else if (!taskModel.isChecked) {
      deleteUndone(docID: taskModel.id, context: context);
      taskModel.isChecked = true;
      projectDone.doc(taskModel.id).set(taskModel.toJson());
    }
    updateCountAndFirstItem(context);
  }

  void deleteUndone({context, docID}) {
    var id = Provider.of<Util>(context, listen: false).id;
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var projectUndone = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(id)
        .collection('$id-undone');
    projectUndone.doc(docID).delete();
    updateCountAndFirstItem(context);
  }

  void deleteDone({context, docID}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var id = Provider.of<Util>(context, listen: false).id;
    var projectDone = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(id)
        .collection('$id-done');
    projectDone.doc(docID).delete();
    updateCountAndFirstItem(context);
  }

  void deleteProject({context, projectID}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var projects = FirebaseFirestore.instance.collection('$userEmail-projects');
    projects.doc(projectID).delete();
  }

  void updateCountAndFirstItem(context) async {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var id = Provider.of<Util>(context, listen: false).id;
    var projects =
        FirebaseFirestore.instance.collection('$userEmail-projects').doc(id);

    var undone = projects.collection('$id-undone').orderBy('dateCreated');
    var done = projects.collection('$id-done');

    QuerySnapshot doneItems = await done.get();
    QuerySnapshot undoneItems = await undone.get();
    var doneCount = doneItems.docs.length;
    var undoneCount = undoneItems.docs.length;
    var totalItems = doneCount + undoneCount;
    var firstItem =
        undoneItems.docs.isNotEmpty ? undoneItems.docs.first.get('item') : '';
    var percentage = (doneCount / totalItems) * 100;
    projects.update({
      'firstItem': firstItem,
      'count': percentage,
      'totalItems': totalItems
    });
  }

  void updateProjectDetails({context, text, color}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var id = Provider.of<Util>(context, listen: false).id;
    var project =
        FirebaseFirestore.instance.collection('$userEmail-projects').doc(id);

    project.update({'title': text, 'color': color});
  }

  void updateDoneTask({docID, context, text}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var id = Provider.of<Util>(context, listen: false).id;

    var projectDone = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(id)
        .collection('$id-done')
        .doc(docID);

    projectDone.update({'item': text});
  }

  void updateUndoneTask({docID, context, text}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var id = Provider.of<Util>(context, listen: false).id;

    var projectUndone = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(id)
        .collection('$id-undone')
        .doc(docID);

    projectUndone.update({'item': text});
  }
}
