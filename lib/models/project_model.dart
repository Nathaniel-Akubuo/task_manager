import 'package:flutter/material.dart';

class ProjectModel {
  String title;
  String? id;
  DateTime dateCreated;
  String? firstItem;
  double? count;
  Color? color;
  int? totalItems;

  ProjectModel(
      {required this.title,
      this.id,
      required this.dateCreated,
      this.firstItem,
      this.count,
      required this.color,
      this.totalItems});

  static ProjectModel fromJson(Map<String, dynamic> data) => ProjectModel(
      id: data['id'],
      title: data['title'],
      color: Color(data['color']),
      count: data['count'],
      firstItem: data['firstItem'],
      dateCreated: DateTime.parse(data['dateCreated']),
      totalItems: data['totalItems']);

  Map<String, dynamic> toJson() => {
        'dateCreated': dateCreated.toString(),
        'id': id,
        'title': title,
        'firstItem': firstItem,
        'color': color!.value,
        'count': count,
        'totalItems': totalItems
      };
}
