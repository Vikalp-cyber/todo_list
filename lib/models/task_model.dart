// task_model.dart

class TaskModel {
  int? id; // Auto-incremented primary key
  String bellName;
  DateTime date;
  String description;
  List<String> selectedDays;

  TaskModel({
    this.id,
    required this.bellName,
    required this.date,
    required this.description,
    required this.selectedDays,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bellName': bellName,
      'date': date.toIso8601String(),
      'description': description,
      'selectedDays': selectedDays.join(','),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      bellName: map['bellName'],
      date: DateTime.parse(map['date']),
      description: map['description'],
      selectedDays: (map['selectedDays'] as String).split(','),
    );
  }
}
