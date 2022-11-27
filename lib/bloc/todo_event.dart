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
  final Todo todo;

  const TodoRemove(this.todo);

  @override
  List<Object> get props => [todo];
}

class TodoComplete extends TodoEvent {
  final Todo todo;

  const TodoComplete(this.todo);

  @override
  List<Object> get props => [todo];
}
