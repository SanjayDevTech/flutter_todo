import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todo/data/models.dart';
import 'package:flutter_todo/data/repository.dart';


part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(this._repository) : super(TodoInitial(_repository.fetchTodos())) {
    on<TodoEvent>((event, emit) {
      if (event is TodoAdd) {
        _repository.addTodo(event.todo);
      } else if (event is TodoRemove) {
        _repository.removeTodoById(event.todo);
      } else if (event is TodoComplete) {
        _repository.completeTodoById(event.todo);
      }
    });
  }

  final Repository _repository;

}
