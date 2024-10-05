import 'package:flutter/material.dart';

class Task {
  final String name;
  bool isCompleted;
  final String priority;

  Task({required this.name, this.isCompleted = false, this.priority = "Low"});
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _taskController = TextEditingController();
  final List<Task> _taskList = [];
  String _selectedPriority = "Low"; // Initial priority

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _taskList
            .add(Task(name: _taskController.text, priority: _selectedPriority));
        _taskController.clear();
        _taskList.sort(
            (a, b) => b.priority.compareTo(a.priority)); // Sort by priority
      });
    }
  }

  void _toggleCompletion(int index) {
    setState(() {
      _taskList[index].isCompleted = !_taskList[index].isCompleted;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _taskList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                hintText: 'Enter task',
              ),
            ),
            DropdownButton<String>(
              value: _selectedPriority,
              onChanged: (value) {
                setState(() {
                  _selectedPriority = value!;
                });
              },
              items: <String>['Low', 'Normal', 'High']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Add'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _taskList.length,
                itemBuilder: (context, index) {
                  final task = _taskList[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) => _toggleCompletion(index),
                    ),
                    title: Text(
                      task.name,
                      style: task.isCompleted
                          ? const TextStyle(
                              color: Colors.grey, /* Add other styles */
                            )
                          : null,
                    ),
                    subtitle: Text('Priority: ${task.priority}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteTask(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
