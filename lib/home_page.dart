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

  Future<List<Todo>> getTodos() async {
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
        })
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
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
