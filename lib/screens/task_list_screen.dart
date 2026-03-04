import 'package:flutter/material.dart';
// Note: In your project, you would import your models and mock data here
import '../models/task.dart';
import '../data/mock_data.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // We bring the list of tasks from our MockData class
  final List<Task> tasks = MockData.myTasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-Do List'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      // FLUTTER CONCEPT: ListView.builder
      // This is the most efficient way to create a list in Flutter.
      // It only renders the items that are visible on the screen!
      body: ListView.builder(
        itemCount: tasks.length, // Tells Flutter how many items to draw
        itemBuilder: (context, index) {
          // We get the specific task object for this position (index)
          final task = tasks[index];

          // UI CONCEPT: ListTile
          // A pre-built widget perfect for lists with a title, subtitle, and icons.
          return ListTile(
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (bool? newValue) {
                // OOP & FLUTTER CONCEPT: setState
                // This function tells Flutter: "Something changed in the data, 
                // please redraw the screen so the user can see it!"
                setState(() {
                  task.isCompleted = newValue ?? false;
                });
              },
            ),
            title: Text(
              task.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // USER STORY #2: Visual indicator for completion
                decoration: task.isCompleted 
                    ? TextDecoration.lineThrough 
                    : TextDecoration.none,
                color: task.isCompleted ? Colors.grey : Colors.black87,
              ),
            ),
            subtitle: Text(task.description),
            trailing: const Icon(Icons.swipe_left, color: Colors.grey, size: 16),
          );
        },
      ),
      // USER STORY #1: The Add Button (+)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // For now, this just prints to the console
          print('User wants to add a new task!');
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
