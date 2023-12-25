import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';

class TaskProvider extends ChangeNotifier{
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;
  void addTask(Task task){
    _tasks.add(task);
    notifyListeners();
  }
  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
  void markTaskAsCompleted(Task task) {
    // Find the task in the list and update its completion status
    final index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index] = task.copyWith(completed: true);
      notifyListeners();
    }
  }

  void markTaskAsPending(Task task) {
    // Find the task in the list and update its completion status
    final index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index] = task.copyWith(completed: false);
      notifyListeners();
    }
  }
  
}