
import 'package:flutter/material.dart';
import 'package:flutter_todo/data/models.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onRemove;
  final VoidCallback onComplete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onRemove,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      decoration:
          todo.completed ? TextDecoration.lineThrough : TextDecoration.none,
    );
    return ListTile(
      title: Text(todo.title, style: textStyle),
      subtitle: Text(todo.description, style: textStyle),
      leading: Checkbox(
        activeColor: Colors.green,
        value: todo.completed,
        onChanged: (value) {
          onComplete();
        },
      ),
      trailing: IconButton(
        color: Colors.red,
        icon: const Icon(Icons.delete),
        onPressed: () {
          onRemove();
        },
      ),
    );
  }
}
