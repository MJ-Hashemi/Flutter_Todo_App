import 'package:flutter/material.dart';
import 'views/todo.dart';
import 'package:provider/provider.dart';
import 'models/task_data.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await TaskData.init();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>TaskData(),
      child: MaterialApp(debugShowCheckedModeBanner: false,
      home: ToDo(),),
    );
  }
}

