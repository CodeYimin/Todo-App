import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key, required this.title});

  final String title;
  final _bigFont = const TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<TodoListModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: todo.completedTasks.length,
          itemBuilder: (context, index) {
            final task = todo.completedTasks[index];
            return ListTile(
              key: Key(task.id),
              title: Text(task.title, style: _bigFont),
              subtitle: Text(task.description),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}
