import 'package:flutter/material.dart';

class TodoAddBottomSheet extends StatelessWidget {
  TodoAddBottomSheet({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text("Add todo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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
          const Spacer(),
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
    );
  }
}
