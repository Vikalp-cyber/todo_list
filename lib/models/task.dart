import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'task.g.dart';


@HiveType(typeId: 0)
class Task extends HiveObject{

  @HiveField(0)
  final String bellName;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final TimeOfDay time;

  @HiveField(3)
  final String description;

  @HiveField(4)
  List<String> selectedDays;

  @HiveField(5)
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
