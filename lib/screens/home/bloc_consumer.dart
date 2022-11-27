import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/bloc/todo_bloc.dart';
import 'package:flutter_todo/data/local/data_inherited.dart';
import 'package:flutter_todo/data/repository.dart';
import 'package:flutter_todo/utils.dart';

import 'data.dart';

class HomeBlocConsumer extends StatelessWidget {
  const HomeBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = TodoBloc(Repository(DataInherited.of(context).todoDao));
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocConsumer<TodoBloc, TodoState>(
        bloc: bloc,
        builder: (blocContext, state) {
          if (state is! TodoInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  var todos = snapshot.data!;
                  return HomeData(
                      todos: todos,
                      addTodo: (todo) {
                        bloc.add(TodoAdd(todo));
                      },
                      removeTodo: (todo) {
                        bloc.add(TodoRemove(todo));
                      },
                      completeTodo: (todo) {
                        bloc.add(TodoComplete(todo));
                      },
                      nextId: () {
                        return generateId();
                      });
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
            stream: state.todosStream,
          );
        },
        listener: (blocContext, state) {

        },
      ),
    );
  }
}
