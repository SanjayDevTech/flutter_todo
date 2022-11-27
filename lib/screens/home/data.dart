import 'package:flutter/material.dart';
import 'package:flutter_todo/data/models.dart';
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
  final Function(String) removeTodo;
  final Function(String) completeTodo;
  final Function(Todo) addTodo;
  final String Function() nextId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: todos.isEmpty ? const Center(child: Text("No Todo to show here!"),) : ListView.builder(
            key: const ValueKey("ListViewKey"),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              var todo = todos[index];
              return TodoItem(
                key: ValueKey(todo.id),
                todo: todo,
                onRemove: () {
                  removeTodo(todo.id);
                },
                onComplete: () {
                  completeTodo(todo.id);
                },
              );
            },
          ),
        ),
        Flexible(
          flex: 0,
          child: ElevatedButton(
            onPressed: () async {
              var data = await showModalBottomSheet<Map<String, String>>(
                  context: context, builder: (_) => TodoAddBottomSheet());
              if (data != null) {
                var todo = Todo(
                  id: nextId(),
                  title: data["title"]!,
                  description: data["description"]!,
                  completed: false,
                );
                addTodo(todo);
              }
            },
            child: const Text("Add Todo"),
          ),
        ),
      ],
    );
  }
}
