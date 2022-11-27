import 'package:flutter/material.dart';
import 'package:flutter_todo/data/models.dart';

class TodoAddBottomSheet extends StatelessWidget {
  TodoAddBottomSheet({super.key});

  // final void Function(String, String) onAdd;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Title",
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {"title": _titleController.text, "description": _descriptionController.text});
                  
                },
                child: const Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
