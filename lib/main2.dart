import 'package:flutter/material.dart';
import 'package:flutter_todo_app/tilesembed.dart';
//import 'todolist.dart';  // Import the todo_list file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Scaffold(
        appBar:  PreferredSize(
          preferredSize: const Size.fromHeight(100.0), // Height of the app bar
          child : Container(
              height : 100,
              width : 600,
              decoration: const BoxDecoration(color: Colors.purple,),
             alignment: Alignment.center,
             child :  const Text('Todo App',style: TextStyle(color: Colors.black,fontSize: 28.0,fontWeight: FontWeight.bold),
          ),),
        ),
        body:  TodoList()//const TodoList(),  // Use the TodoList widget here
      ),
    );
  }
}
