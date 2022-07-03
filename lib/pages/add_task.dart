import 'package:flutter/material.dart';

typedef OnAddListener = void Function(String title, String description);

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key, required this.onAdd});

  final OnAddListener onAdd;

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final formKey = GlobalKey<FormState>();
  var _title = '';
  var _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo Item'),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
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
                decoration: const InputDecoration(hintText: 'Description'),
                onChanged: (value) => setState(() => _description = value),
                minLines: 1,
                maxLines: 10,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    widget.onAdd(_title, _description);
                  }
                },
                child: const Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
