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

  void addToDo({context, required TaskModel taskModel}) async {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var util = Provider.of<Util>(context, listen: false);
    var projects = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(util.id);

    var doc = projects.collection('${util.title}-undone').doc();
    taskModel.id = doc.id;
    doc.set(taskModel.toJson());
    updateCountAndFirstItem(context);
  }

  void toggleDone({context, required TaskModel taskModel}) {
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
    updateCountAndFirstItem(context);
  }

  void deleteUndone({context, id}) {
    var util = Provider.of<Util>(context, listen: false);
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var projectUndone = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(util.id)
        .collection('${util.title}-undone');
    projectUndone.doc(id).delete();
    updateCountAndFirstItem(context);
  }

  void updateCountAndFirstItem(context) async {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var util = Provider.of<Util>(context, listen: false);
    var projects = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(util.id);

    var undone = projects.collection('${util.title}-undone');
    var done = projects.collection('${util.title}-done');

    QuerySnapshot doneItems = await done.get();
    QuerySnapshot undoneItems = await undone.get();
    var doneCount = doneItems.docs.length;
    var undoneCount = undoneItems.docs.length;
    var firstItem =
        undoneItems.docs.isNotEmpty ? undoneItems.docs.first.get('item') : '';
    var percentage = (doneCount / (undoneCount + doneCount)) * 100;
    projects.update({'firstItem': firstItem, 'count': percentage});
  }

  void deleteDone({context, id}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var util = Provider.of<Util>(context, listen: false);
    var projectDone = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(util.id)
        .collection('${util.title}-done');
    projectDone.doc(id).delete();
    updateCountAndFirstItem(context);
  }

  void updateProjectTitle({context, id, text}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var util = Provider.of<Util>(context, listen: false);
    var project = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(util.id);

    project.update({'title': text});
  }

  void updateDoneTask({id, context, text}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var util = Provider.of<Util>(context, listen: false);

    var projectDone = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(util.id)
        .collection('${util.title}-done')
        .doc(id);

    projectDone.update({'item': text});
  }

  void updateUndoneTask({id, context, text}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var util = Provider.of<Util>(context, listen: false);

    var projectUndone = FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(util.id)
        .collection('${util.title}-undone')
        .doc(id);

    projectUndone.update({'item': text});
  }
}
