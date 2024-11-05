import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Map<String, dynamic>>_tasks = [];
  TextEditingController _taskController = TextEditingController();

  // Variable to track if the text field is shown
  bool _isAddingTask = false;

  // Method to add a new task
  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add({
          'task': _taskController.text,
          'isCompleted': false,
            'color': Colors.purple.shade400, 
        });
        _taskController.clear();
        _isAddingTask = false;
         _sortTasks();   // Hide the text field after adding
      });
    }
  }

  // Method to toggle task completion status
 void _toggleTask(int index) {
    setState(() {
      _tasks[index]['isCompleted'] = !_tasks[index]['isCompleted'];
       _sortTasks(); 
    });
  }

  // Method to delete a task
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _sortTasks() {
    _tasks.sort((a, b) {
      if (a['isCompleted'] == b['isCompleted']) return 0;
      return a['isCompleted'] ? 1 : -1;  // Completed tasks go to the bottom
    });
  }
  // Method to edit a task
  void _editTask(int index, String newTask) {
    setState(() {
      _tasks[index]['task'] = newTask;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        height: 730,
        width: 750,
        color: Colors.purple.shade500,
      child : Column(
        children: [
          // Task list
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Container(
                    color: _tasks[index]['color'], 
                     margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0), // Margin around each task
                    padding: const EdgeInsets.all(5.0),
                   child :ListTile(
                  title: Text(
                    _tasks[index]['task'],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      decoration: _tasks[index]['isCompleted']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                          decorationColor: Colors.purple,  // Set the line color for completed tasks
                          color: _tasks[index]['isCompleted'] ? Colors.purple : Colors.black,  // Set text color based on completion status
   
                      //color: _tasks[index]['isCompleted'] ? Colors.grey : Colors.black,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Toggle task completion
                      IconButton(
                        icon: Icon(
                          _tasks[index]['isCompleted']
                              ? Icons.check_circle_outline
                              : Icons.radio_button_unchecked,
                          color: _tasks[index]['isCompleted'] ? Colors.brown: Colors.grey,
                          //color: _tasks[index]['isCompleted'] ? Colors.blue: Colors.grey,
                          
                        ),
                        onPressed: () => _toggleTask(index),
                      ),
                      // Edit task button
                      IconButton(
                        icon: const Icon(Icons.edit, color:Colors.black87),
                      
                        onPressed: () {
                          TextEditingController _editController = TextEditingController();
                          _editController.text = _tasks[index]['task'];
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Edit Task'),
                                content: TextField(
                                  controller: _editController,
                                  decoration: InputDecoration(
                                    labelText: 'Edit task',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      _editTask(index, _editController.text);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      // Delete task button
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.black87,),
                        onPressed: () => _deleteTask(index),
                      ),
                    ],
                  ),
                ),
                );
              },
            ),
          ),
           SizedBox(height: 10.0), 
          // Conditional Text Field
          if (_isAddingTask)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  labelText: 'Enter a task',
                  labelStyle:  const TextStyle(fontSize: 19.0,color: Colors.black),
                  focusColor: Colors.black,
                  filled: true,
                  fillColor: Colors.purple.shade300,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: _addTask,
                  ),
                ),
                onSubmitted: (_) => _addTask(), style: TextStyle(fontSize: 20.0),  // Also add task on "Enter" key
              ),
            ),
        ],
      ),),
      
      // Floating Action Button to add new task
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isAddingTask = !_isAddingTask;  // Toggle text field visibility
          });
        },
        child: Icon(Icons.add),
        tooltip: 'Add a new task',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,  // Position at bottom right
      
    );
  }
}
