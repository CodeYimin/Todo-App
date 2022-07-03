import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/pages/add_task.dart';
import 'package:todoapp/pages/completed_tasks.dart';
import 'package:todoapp/pages/edit_task.dart';

import '../models/todo_list.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key, required this.title});

  final String title;
  final _bigFont = const TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<TodoListModel>();

    void _handleAddTask() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) {
            return AddItemScreen(
              onAdd: (title, description) {
                Navigator.of(context).pop();
                todo.add(
                  TodoTask(
                    id: UniqueKey().toString(),
                    title: title,
                    description: description,
                  ),
                );
              },
            );
          }),
        ),
      );
    }

    void _handleEditTask(TodoTask task) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) {
            return EditTaskScreen(
              task: task,
              onEdit: (title, description) {
                Navigator.of(context).pop();
                todo.editTask(
                  id: task.id,
                  title: title,
                  description: description,
                );
              },
            );
          }),
        ),
      );
    }

    void _handleDeleteTask(TodoTask task) {
      todo.removeTask(task);
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Center(
            heightFactor: 1,
            child: Text('You deleted a task.'),
          ),
        ),
      );
    }

    void _handleCompleteTask(TodoTask task) {
      todo.completeTask(task);
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Center(
            heightFactor: 1,
            child: Text('Yay! You completed a task.'),
          ),
        ),
      );
    }

    void _handleShowCompletedTasks() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) {
            return const CompletedTasksScreen(title: 'Completed Tasks');
          }),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: _handleShowCompletedTasks,
            icon: const Icon(Icons.library_books),
            tooltip: 'Completed Tasks',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: todo.tasks.length,
          itemBuilder: (context, index) {
            final task = todo.getTaskByIndex(index);
            return ListTile(
              key: Key(task.id),
              title: Text(task.title, style: _bigFont),
              subtitle:
                  task.description.isEmpty ? null : Text(task.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _handleEditTask(task),
                    tooltip: 'Edit Task',
                  ),
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () => _handleCompleteTask(task),
                    tooltip: 'Complete Task',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _handleDeleteTask(task),
                    tooltip: 'Delete Task',
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddTask,
        tooltip: 'Create Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
