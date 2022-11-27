part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
  
  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {
  final Stream<List<Todo>> todosStream;
  const TodoInitial(this.todosStream);
}

