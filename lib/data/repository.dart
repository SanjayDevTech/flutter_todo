import 'dart:async';

import 'data_provider.dart';
import 'models.dart';

class Repository {
  final DataProvider _dataProvider;
  final StreamController<List<Todo>> _todosStreamController =
      StreamController();

  Repository(this._dataProvider) {
     fetchTodos();
  }

  Stream<List<Todo>> get todosStream => _todosStreamController.stream;

  Future<void> fetchTodos() async {
    var todos = await _dataProvider.getTodos();
    _todosStreamController.add(todos);
  }

  Future<void> addTodo(Todo todo) async {
    await _dataProvider.addTodo(todo);
    await fetchTodos();
  }

  Future<void> removeTodoById(String id) async {
    await _dataProvider.removeTodo(id);
    await fetchTodos();
  }

  Future<void> completeTodoById(String id) async {
    await _dataProvider.completeTodo(id);
    await fetchTodos();
  }
}
