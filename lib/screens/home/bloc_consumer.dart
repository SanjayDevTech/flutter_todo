import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/bloc/todo_bloc.dart';
import 'package:flutter_todo/data/data_provider.dart';
import 'package:flutter_todo/data/repository.dart';
import 'package:flutter_todo/utils.dart';

import 'data.dart';

final dataProvider = DataProvider();

class HomeBlocConsumer extends StatelessWidget {
  HomeBlocConsumer({super.key});
  final bloc = TodoBloc(Repository(dataProvider));

  @override
  Widget build(BuildContext context) {
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
                        removeTodo: (id) {
                          bloc.add(TodoRemove(id));
                        },
                        completeTodo: (id) {
                          bloc.add(TodoComplete(id));
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
              stream: state.todosStream);
        },
        listener: (blocContext, state) {
          // context.read<TodoBloc>()
        },
      ),
    );
  }
}
