import 'package:flutter/material.dart';
import 'package:todo/models/task_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BuildTask extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, TaskData, child) {
      return ReorderableListView.builder(
        padding: EdgeInsets.symmetric(vertical: 5),
          onReorder: (oldIndex, newIndex) =>
              TaskData.onReorder(oldIndex, newIndex),
          itemCount: TaskData.taskCount,
          itemBuilder: (BuildContext context, int index) {
            final task = TaskData.tasks[index];
            return Slidable(
              key: ValueKey(task.id),
              startActionPane: ActionPane(
                dismissible:DismissiblePane(onDismissed:(){

                  TaskData.deleteTask(task);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('${task.name} has been deleted')));
                } ) ,

                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.indigo,
                    onPressed:(_)=> doSomeThing(context,Job.delete,task),
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    backgroundColor: Colors.lightBlueAccent,
                    onPressed: (_) {},
                    icon: Icons.edit,
                    label: 'Edit',
                  )
                ],
              ),
              endActionPane:ActionPane(
                motion:const DrawerMotion(),
                children: [SlidableAction(onPressed:(_){},
                backgroundColor:Colors.cyan ,
                icon: Icons.archive,
                label: 'Archive',)],
              ),
              child: Card(
                shadowColor: Colors.black ,
                color: task.isDone ? Colors.black38 : null,
                elevation:5 ,
                child: CheckboxListTile(
                  value: task.isDone,
                  onChanged: (newValue) {
                    TaskData.updateTask(task);
                  },
                  title: Text(
                    "${task.name}",
                    style: TextStyle(
                        decoration:
                            task.isDone ? TextDecoration.lineThrough : null),
                  ),
                ),
              ),
            );
          });
    });
  }
}
enum Job {delete , edit , archive}

void doSomeThing(BuildContext context,Job job , dynamic task){
  switch(job){
    case Job.delete:
      Provider.of<TaskData>(context,listen:false).deleteTask(task);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('${task.name} has been deleted')));
      break;
    case Job.archive:
      break;
    case Job.edit:
      break;
  }
}