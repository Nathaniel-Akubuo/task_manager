import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/project_model.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/services/user_service.dart';

class ProjectsProvider extends ChangeNotifier {
  createProject({context, required ProjectModel projectModel}) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var projects = FirebaseFirestore.instance
        .collection('$userEmail-projects');
    var doc = projects.doc();
    projectModel.id = doc.id;

    doc.set(projectModel.toJson());

  }

  addTodo({context, required TaskModel taskModel}) {
//    var userEmail = Provider.of<UserService>(context, listen: false).email;
//    var projects = FirebaseFirestore.instance.collection('$userEmail-projects');
  }
}
