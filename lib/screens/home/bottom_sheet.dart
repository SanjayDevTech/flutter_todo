import 'package:flutter/material.dart';

class TodoAddBottomSheet extends StatelessWidget {
  const TodoAddBottomSheet({super.key, required this.titleController, required this.descriptionController});

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      // padding: const EdgeInsets.all(16.0),
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Add todo",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autofocus: true,
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  hintText: 'Enter title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  hintText: 'Enter description',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
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
