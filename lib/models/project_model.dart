import 'package:flutter/material.dart';

class ProjectModel {
  String title;
  String id;
  DateTime dateCreated;
  String? firstItem;
  Color color;

  ProjectModel(
      {required this.title,
      required this.id,
      required this.dateCreated,
      this.firstItem,
      required this.color});

  static ProjectModel fromJson(Map<String, dynamic> data) => ProjectModel(
      id: data['id'],
      title: data['title'],
      color: Color(data['color']),
      dateCreated: DateTime.parse(data['dateCreated']));

  Map<String, dynamic> toJson() => {
        'dateCreated': dateCreated.toString(),
        'id': id,
        'title': title,
        'firstItem': firstItem,
        'color': color.value
      };
}
