import 'package:flutter/material.dart';

void main() => runApp(ToDo());

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState(); 
}

class _ToDoState extends State<ToDo> {
  List<String> tasks = []; 
  List<bool> isChecked = []; 
  TextEditingController taskController = TextEditingController();

  // Function to add task to the list
  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(taskController.text);
        isChecked.add(false); 
        taskController.clear(); 
      });
    }
  }

  // Checkbox color change based on state
  Color getColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return Colors.green; 
    }
    return Colors.white; 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('My To-Do List'),
          backgroundColor: const Color.fromARGB(255, 52, 172, 160),
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your task',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: addTask,
                child: Text('Add Task'),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          checkColor: Colors.white, 
                          fillColor: WidgetStateProperty.resolveWith(getColor),
                          value: isChecked[index],
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked[index] = value!;
                            });
                          },
                        ),
                        title: Text(
                          tasks[index],
                          style: TextStyle(
                            decoration: isChecked[index]
                                ? TextDecoration.lineThrough 
                                : TextDecoration.none, 
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              tasks.removeAt(index);
                              isChecked.removeAt(index); 
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}  
