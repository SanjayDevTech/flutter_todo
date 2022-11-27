import 'dart:async';

import 'package:flutter_todo/data/local/entities.dart';

import 'local/dao.dart';
import 'convertor.dart';
import 'models.dart';

class Repository {
  late TodoDao _todoDao;

  Repository(this._todoDao);

  Stream<List<Todo>> fetchTodos() {
    return _todoDao.getAllTodos().map((event) => event.map((e) => e.model).toList());
  }

  Future<void> addTodo(Todo todo) async {
    return await _todoDao.insertTodo(todo.entity);
  }

  Future<void> removeTodoById(Todo todo) async {
    return await _todoDao.deleteTodo(todo.entity);
  }

  Future<void> completeTodoById(Todo todo) async {
    final updatedTodo = todo.copyWith(completed: !todo.completed);
    return await _todoDao.updateTodo(updatedTodo.entity);
  }
}
