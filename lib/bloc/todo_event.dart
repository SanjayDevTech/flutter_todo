part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoAdd extends TodoEvent {
  final Todo todo;

  const TodoAdd(this.todo);

  @override
  List<Object> get props => [todo];
}

class TodoRemove extends TodoEvent {
  final String id;

  const TodoRemove(this.id);

  @override
  List<Object> get props => [id];
}

class TodoComplete extends TodoEvent {
  final String id;

  const TodoComplete(this.id);

  @override
  List<Object> get props => [id];
}
