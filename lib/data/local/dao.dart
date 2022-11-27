
import 'package:floor/floor.dart';
import 'package:flutter_todo/data/local/entities.dart';

@dao
abstract class TodoDao {

  @Query('SELECT * FROM TodoEntity')
  Stream<List<TodoEntity>> getAllTodos();

  @delete
  Future<void> deleteTodo(TodoEntity todoEntity);

  @update
  Future<void> updateTodo(TodoEntity todoEntity);

  @insert
  Future<void> insertTodo(TodoEntity todoEntity);
}