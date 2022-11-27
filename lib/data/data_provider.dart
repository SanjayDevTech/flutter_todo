import 'dart:convert';

import 'package:flutter/services.dart';

import 'models.dart';

class DataProvider {
  List<Todo>? _todosList;

  List<Todo> get todosList => _todosList!;


  Future<void> init() async {
    var jsonString = await rootBundle.loadString('assets/data/todos.json');
    _todosList =
        (jsonDecode(jsonString) as List).map((e) => Todo.fromJson(e)).toList();
  }

  Future<List<Todo>> getTodos() async {
    if (_todosList == null) {
      await init();
    }
    return todosList;
  }

  Future<void> removeTodo(String id) async {
    todosList.removeWhere((element) => element.id == id);
  }

  Future<void> addTodo(Todo todo) async {
    todosList.add(todo);
  }

  Future<void> completeTodo(String id) async {
    _todosList = todosList.map((e) {
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
  }
}
