import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:todo_list/models/task.dart';
import 'package:todo_list/provider/taskProvider.dart';
import 'package:todo_list/services/notifi.dart';
import 'package:todo_list/utils/textstyle.dart';
import 'package:todo_list/widgets/custom_heading.dart';
import 'package:todo_list/widgets/custom_text_field.dart';

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({super.key});

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime; // Make it nullable
  TextEditingController tasknameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  
 

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void submitTask(BuildContext context) {
    final TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);
    DateTime combinedDateTime = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    selectedTime?.hour ?? 0,
    selectedTime?.minute ?? 0,
  );

    Task newTask = Task(
      taskName: tasknameController.text,
      date: selectedDate,
      time: selectedTime ?? TimeOfDay.now(),
      description: descriptionController.text,
    );
    taskProvider.addTask(newTask);
    print(newTask);
    NotificationService().scheduleNotification(title: 'Scheduled Notification',
            body: '$combinedDateTime',scheduledNotificationDateTime: combinedDateTime);
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 5.h, left: 2.w, right: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                  ),
                  Text(
                    "Create New Task",
                    style: MyText.MyText2,
                  ),
                ],
              ),
              Heading("Task Name"),
              CustomTextField("Task Name", tasknameController),
              Heading("Date & Time"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 7.h,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 3.w),
                        child: Text(
                          DateFormat('dd MMMM yyyy').format(
                            selectedDate.toLocal(),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () => _selectDate(context),
                          icon: const Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 7.h,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 3.w),
                        child: Text(
                            " ${selectedTime != null ? selectedTime!.format(context) : 'Not selected'}"),
                      ),
                      IconButton(
                          onPressed: () => _selectTime(context),
                          icon: const Icon(
                            Icons.access_time,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                ),
              ),
              Heading("Description"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Description of the task....",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 3.h),
                width: double.infinity,
                height: 7.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () => submitTask(context),
                  child: Text(
                    "Submit",
                    style: MyText.MyText1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
