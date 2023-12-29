import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/services/notification.dart';
import 'package:todo_list/utils/textstyle.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Notifications notification = Notifications();

  @override
  void initState() {
    super.initState();
    // notification.initializeNotification();
  }

  // Function to get tasks from Hive
  Future<List<Task>> _getTasks() async {
    final box = await Hive.openBox<Task>('tasks');
    return box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Digital Bell",
          style: MyText.MyText1,
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createnewtask');
          notification.sendNotification('title', 'body');
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        // Use a FutureBuilder to read data from Hive asynchronously
        future: _getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display a loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return _buildTaskList(snapshot.data as List<Task>); // Build the task list when data is available
          }
        },
      ),
    );
  }

  // Function to build the task list
  Widget _buildTaskList(List<Task> tasks) {
    return Container(
      margin: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w, bottom: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Upcoming Bell",
              style: MyText.MyText2,
            ),
          ),
          // Display tasks dynamically
          SizedBox(
            height: 1.5.h,
          ),
          Column(
            children: tasks.map((task) {
              return Dismissible(
                key: Key(task.bellName),
                onDismissed: (direction) {
                  // Remove the task from Hive when dismissed
                  // Add your logic to delete the task from Hive
                },
                background: Container(
                  color: Colors.red, // Background color when swiping
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (task.completed)
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          Container(
                            margin: EdgeInsets.only(left: 2.w),
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.bellName,
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                for (int i = 0;
                                    i < task.selectedDays.length;
                                    i++)
                                  Text(
                                    task.selectedDays[i],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 10.sp, color: Colors.grey),
                                  )
                              ],
                            ),
                          ),
                          Text(
                            // Format your time as needed
                            '${task.time.hour}:${task.time.minute}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              // Handle menu item selection
                              if (value == 'Completed') {
                                // Add your logic to mark task as completed
                              } else if (value == 'Pending') {
                                // Add your logic to mark task as pending
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return ['Completed', 'Pending']
                                  .map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
