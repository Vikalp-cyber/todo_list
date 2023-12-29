import 'package:hive/hive.dart';
import 'package:todo_list/models/task.dart';

class DatabaseHelper {
  static const String boxName = 'tasks'; // Declare a constant box name

  static Future<void> insertTask(Task task) async {
    final box = await Hive.openBox<Task>(boxName); // Use the same type consistently
    await box.add(task);
  }

  static Future<List<Task>> getAllTasks() async {
    final box = await Hive.openBox<Task>(boxName); // Use the same type consistently
    return box.values.toList();
  }
}
