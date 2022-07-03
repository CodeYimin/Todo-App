import 'package:flutter/material.dart';

import '../models/todo_list.dart';

typedef OnEditListener = void Function(String title, String description);

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.onEdit, required this.task});

  final OnEditListener onEdit;
  final TodoTask task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  void initState() {
    super.initState();

    _title = widget.task.title;
    _description = widget.task.description;
  }

  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo Item'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: _title,
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Title'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => _title = value),
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(hintText: 'Description'),
                onChanged: (value) => setState(() => _description = value),
                minLines: 1,
                maxLines: 10,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onEdit(_title, _description);
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
