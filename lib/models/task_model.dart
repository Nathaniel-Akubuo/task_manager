class TaskModel {
  DateTime dateCreated;
  bool isChecked;
  String item;

  TaskModel(
      {required this.dateCreated, required this.item, required this.isChecked});

  static TaskModel fromJson(Map<String, dynamic> data) => TaskModel(
      dateCreated: DateTime.parse(data['dateCreated']),
      item: data['item'],
      isChecked: data['isChecked']);

  Map<String, dynamic> toJson() => {
        'dateCreated': dateCreated.toString(),
        'item': item,
        'isChecked': isChecked,
      };
}
