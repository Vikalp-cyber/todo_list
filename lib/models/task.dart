import 'package:flutter/material.dart';

class Task {
  final String taskName;
  final DateTime date;
  final TimeOfDay time;
  final String description;
  bool completed;

  Task({
    required this.taskName,
    required this.date,
    required this.time,
    required this.description,
    this.completed = false,
  });

  Task copyWith({
    String? taskName,
    DateTime? date,
    TimeOfDay? time,
    String? description,
    bool? completed,
  }) {
    return Task(
      taskName: taskName ?? this.taskName,
      date: date ?? this.date,
      time: time ?? this.time,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }

  @override
  String toString() {
    return "$taskName , $date , $time , $description";
  }
}
