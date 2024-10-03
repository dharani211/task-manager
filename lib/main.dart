import 'package:flutter/material.dart';
import 'package:coursew4/task.dart'; // Replace 'your_project_name' with your actual project name

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      home: TaskListScreen(),
    );
  }
}
