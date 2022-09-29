import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  String newTaskTitle = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Add Task",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueAccent, fontSize: 30)),
          TextField(
            onChanged: (name) {
              newTaskTitle = name;
            },
            decoration: InputDecoration(),
            autofocus: true,
            textAlign: TextAlign.center,
            cursorHeight: 30,
            cursorWidth: 2.5,
            style: TextStyle(fontSize: 18),
          ),
          ElevatedButton(
              onPressed: () {
                if (newTaskTitle.isNotEmpty) {
                  Provider.of<TaskData>(context, listen: false)
                      .addTask(newTaskTitle);
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Add",
              ))
        ],
      ),
    );
  }
}
