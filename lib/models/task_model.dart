class TaskModel {
  DateTime dateCreated;
  String id;
  bool isChecked;
  String item;

  TaskModel(
      {required this.dateCreated,
      required this.id,
      required this.item,
      required this.isChecked});

  static TaskModel fromJson(Map<String, dynamic> data) => TaskModel(
      dateCreated: DateTime.parse(data['dateCreated']),
      id: data['id'],
      item: data['item'],
      isChecked: data['isChecked']);

  Map<String, dynamic> toJson() => {
        'dateCreated': dateCreated.toString(),
        'id': id,
        'item': item,
        'isChecked': isChecked
      };
}
