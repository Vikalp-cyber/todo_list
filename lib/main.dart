import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/models/timeOfDay.dart';
import 'package:todo_list/provider/taskProvider.dart';
import 'package:todo_list/screens/create_new_task.dart';
import 'package:todo_list/screens/homepage.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo_list/services/database.dart';
import 'package:todo_list/services/notifi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  // Hive.init(directory.path);
  
  await Hive.initFlutter();
  await initPathProvider();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter<TimeOfDay>(TimeOfDayAdapter()); 
  await Hive.openBox<Task>(DatabaseHelper.boxName);
  // Hive.registerAdapter<Task>(TaskAdapter());
  // NotificationService().initNotification();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

Future<void> initPathProvider() async {
  await getTemporaryDirectory();
  await getApplicationDocumentsDirectory();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      

      return ChangeNotifierProvider(
        create: (context) => TaskProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: '/',
          routes: {
            '/': (context) => const MyHomePage(),
            '/createnewtask': (context) => const CreateNewTask(),
          },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
        ),
      );
    });
  }
}
