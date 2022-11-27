import 'package:flutter/material.dart';
import 'package:flutter_todo/data/local/data_inherited.dart';
import 'package:flutter_todo/data/models.dart';
import 'package:flutter_todo/data/repository.dart';
import 'bottom_sheet.dart';
import 'todo_item.dart';

class HomeData extends StatelessWidget {
  const HomeData(
      {super.key,
      required this.todos,
      required this.addTodo,
      required this.removeTodo,
      required this.completeTodo,
      required this.nextId});

  final List<Todo> todos;
  final Function(Todo) removeTodo;
  final Function(Todo) completeTodo;
  final Function(Todo) addTodo;
  final String Function() nextId;

  @override
  Widget build(BuildContext context) {
    final repository = Repository(DataInherited.of(context).todoDao);
    return Column(
      children: [
        Flexible(
          child: todos.isEmpty
              ? const Center(
                  child: Text("No Todo to show here!"),
                )
              : ListView.builder(
                  key: const ValueKey("ListViewKey"),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    var todo = todos[index];
                    return TodoItem(
                      key: ValueKey(todo.id),
                      todo: todo,
                      onRemove: () {
                        removeTodo(todo);
                      },
                      onComplete: () {
                        completeTodo(todo);
                      },
                    );
                  },
                ),
        ),
        Flexible(
          flex: 0,
          child: ElevatedButton(
            onPressed: () async {
              final titleTextController = TextEditingController();
              final descriptionTextController = TextEditingController();
              var data = await showModalBottomSheet<bool>(
                isScrollControlled: true,
                context: context,
                builder: (_) {
                  return TodoAddBottomSheet(
                    titleController: titleTextController,
                    descriptionController: descriptionTextController,
                  );
                },
              );
              if (data == true) {
                var todo = Todo(
                  id: nextId(),
                  title: titleTextController.text,
                  description: descriptionTextController.text,
                  completed: false,
                );
                repository.addTodo(todo);
              }
            },
            child: const Text("Add Todo"),
          ),
        ),
      ],
    );
  }
}
