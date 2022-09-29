

import 'package:flutter/material.dart';

class Task {
  late int id ;
  final String name ;
  late bool isDone;
  Task({required this.name , this.isDone = false,}){id = UniqueKey().hashCode;}

   Task.fromMap(Map map):
      id = map['id'],
      name=map['name'],
  isDone=map['isDone'];

  void toggleDone(){
    isDone = !isDone;
}
Map toMap(){
    return {
      'id':id,
      'name':name,
      'isDone':isDone
    };
}
}