import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class Todo {
  final int id;
  final String title;
  final String description;
  final bool completed;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
    };
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, description: $description, completed: $completed}';
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: const HomeTodoList(),
    );
  }
}

class HomeTodoList extends StatefulWidget {
  const HomeTodoList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeTodoListState createState() => _HomeTodoListState();
}

class _HomeTodoListState extends State<HomeTodoList> {
  List<Todo> _todosList = [];
  int _nextIndex = 0;

  Future<List<Todo>> getTodos() async {
    await Future.delayed(const Duration(seconds: 4));
    var jsonString = await rootBundle.loadString('assets/data/todos.json');
    var json =
        (jsonDecode(jsonString) as List).map((e) => Todo.fromJson(e)).toList();
    return json;
  }

  void removeTodo(int id) {
    setState(() {
      _todosList.removeWhere((element) => element.id == id);
    });
  }

  void completeTodo(int id) {
    setState(() {
      _todosList = _todosList.map((e) {
        if (e.id == id) {
          return Todo(
            id: e.id,
            title: e.title,
            description: e.description,
            completed: !e.completed,
          );
        }
        return e;
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getTodos().then(
      (value) => {
        setState(() {
          _todosList = value;
          _nextIndex = _todosList.length + 1;
        })
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            key: const ValueKey("ListViewKey"),
            itemCount: _todosList.length,
            itemBuilder: (context, index) {
              var todo = _todosList[index];
              return TodoItem(
                key: ValueKey(todo.id),
                todo: _todosList[index],
                onRemove: () {
                  removeTodo(todo.id);
                },
                onComplete: () {
                  completeTodo(todo.id);
                },
              );
            },
          ),
        ),
        Flexible(
          flex: 0,
          child: ElevatedButton(
            onPressed: () {
              late PersistentBottomSheetController controller;
              controller = Scaffold.of(context).showBottomSheet((context) {
                return TodoAddBottomSheet(
                  onAdd: (title, description) {
                    controller.close();
                    setState(() {
                      _todosList.add(Todo(
                          id: _nextIndex,
                          title: title,
                          description: description,
                          completed: false));
                          
                      _nextIndex++;
                    });
                  },
                );
              });
            },
            child: const Text("Add Todo"),
          ),
        ),
      ],
    );
  }
}

class TodoAddBottomSheet extends StatelessWidget {
  TodoAddBottomSheet({super.key, required this.onAdd});

  final void Function(String, String) onAdd;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
      children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: "Title",
            ),
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: "Description",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onAdd(
                _titleController.text,
                _descriptionController.text,
              );
            },
            child: const Text("Add"),
          ),
      ],
    ),
        ));
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onRemove;
  final VoidCallback onComplete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onRemove,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      decoration:
          todo.completed ? TextDecoration.lineThrough : TextDecoration.none,
    );
    return ListTile(
      title: Text(todo.title, style: textStyle),
      subtitle: Text(todo.description, style: textStyle),
      leading: Checkbox(
        value: todo.completed,
        onChanged: (value) {
          onComplete();
        },
      ),
      trailing: IconButton(
        color: Colors.red,
        icon: const Icon(Icons.delete),
        onPressed: () {
          onRemove();
        },
      ),
    );
  }
}
