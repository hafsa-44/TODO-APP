import 'package:flutter/material.dart';

class TodoListe extends StatefulWidget {
  const TodoListe({super.key});

  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoListe> {
  // List to store tasks with colors
  List<Map<String, dynamic>> tasks = [];

  // Controller to manage task input
  TextEditingController taskController = TextEditingController();

  // Method to add a new task
  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add({
          'task': taskController.text,
          'isCompleted': false,
          'color': Colors.blueGrey, // Assign a random color
        });
        taskController.clear();
      });
    }
  }

  // Method to toggle task completion status
  void toggleTask(int index) {
    setState(() {
      tasks[index]['isCompleted'] = !tasks[index]['isCompleted'];
    });
  }

  // Method to delete a task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // Method to edit a task
  void editTask(int index, String newTask) {
    setState(() {
      tasks[index]['task'] = newTask;
    });
  }

  // Generate a random color


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 730,
        width: 750,
        color: Colors.white,
        child: Column(
          children: [
            // Input field to add a task
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: taskController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.tealAccent,
                  labelText: 'Enter a task',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: addTask,
                                    ),
                ),
              ),
            ),

            // Space between TextField and ListView
            SizedBox(height: 8.0), // Optional space

            // Task list
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: tasks[index]['color'], 
                     margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Margin around each task
                    padding: const EdgeInsets.all(5.0), // Set background color of the task
                    child: ListTile(
                      title: Text(
                        tasks[index]['task'],
                        style: TextStyle(
                          decoration: tasks[index]['isCompleted']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: tasks[index]['isCompleted'] ? Colors.grey : Colors.white, // Adjust text color
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Toggle task completion
                          IconButton(
                            icon: Icon(
                              tasks[index]['isCompleted']
                                  ? Icons.check_circle_outline
                                  : Icons.radio_button_unchecked,
                              color: tasks[index]['isCompleted'] ? Colors.blue : Colors.grey,
                            ),
                            onPressed: () => toggleTask(index),
                          ),
                          // Edit task button
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              TextEditingController editController = TextEditingController();
                              editController.text = tasks[index]['task'];
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Edit Task'),
                                    content: TextField(
                                      controller: editController,
                                      decoration: const InputDecoration(
                                        labelText: 'Edit task',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          editTask(index, editController.text);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          // Delete task button
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteTask(index),
                          ),
                        ],
                      ),
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
