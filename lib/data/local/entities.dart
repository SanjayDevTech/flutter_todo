import 'package:floor/floor.dart';

@entity
class TodoEntity {

  @primaryKey
  final String id;

  final String title;
  final String description;
  final bool completed;

  TodoEntity(this.id, this.title, this.description, this.completed);
}