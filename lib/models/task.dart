import 'package:flutter/material.dart';

class Task {
  final String bellName;
  final DateTime date;
  final TimeOfDay time;
  final String description;
  List<String> selectedDays;
  bool completed;

  Task({
    required this.bellName,
    required this.date,
    required this.time,
    required this.description,
    this.completed = false,
    required this.selectedDays,
  });

  Task copyWith({
    String? bellName,
    DateTime? date,
    TimeOfDay? time,
    String? description,
    bool? completed,
  }) {
    return Task(
      bellName: bellName ?? this.bellName,
      date: date ?? this.date,
      time: time ?? this.time,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      selectedDays: selectedDays 
    );
  }

  @override
  String toString() {
    return "$bellName , $date , $time , $description";
  }
}
