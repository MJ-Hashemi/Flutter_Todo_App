import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskData extends ChangeNotifier {
  static List<Task> _tasks = [
  ];

  UnmodifiableListView get tasks {
    return UnmodifiableListView(_tasks);
  }

  static SharedPreferences? _preferences;

  int get taskCount => _tasks.length;

  void addTask (String newTaskTitle){
    final task =Task(name: newTaskTitle);
    _tasks.add(task);
    saveData();
    notifyListeners();
  }
  void onReorder(int oldIndex , int newIndex){
    if (oldIndex < newIndex){
      newIndex -=1;
    }
    final Task task = _tasks.removeAt(oldIndex);
    _tasks.insert(newIndex, task );
    notifyListeners();
  }
  void updateTask(Task task){
    task.toggleDone();
    updateData();
    notifyListeners();
  }
  void deleteTask(Task task){
    _tasks.remove(task);
    updateData();
    notifyListeners();
  }
   void saveData(){
    List<String>? saveData = _tasks.map((task) => jsonEncode(task.toMap())).toList();
    _preferences!.setStringList("TaskData", saveData);
  }

  void updateData(){
    _preferences!.remove("TaskData");
    saveData();
  }
  static Future init() async {
     _preferences = await SharedPreferences.getInstance();
     loadData();

  }

  static void loadData(){
    List<String>? saveData = _preferences!.getStringList("TaskData");
    if( saveData != null ){
      _tasks = saveData.map((task) => Task.fromMap(jsonDecode(task))).toList();
    }
  }


}
