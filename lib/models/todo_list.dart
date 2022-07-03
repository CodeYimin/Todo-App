import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class TodoListModel with ChangeNotifier {
  final _tasks = <TodoTask>[];
  final _completedTasks = <TodoTask>[];

  List<TodoTask> get tasks => List.unmodifiable(_tasks);
  List<TodoTask> get completedTasks => List.unmodifiable(_completedTasks);

  TodoTask? getTaskById(String id) {
    return _tasks.firstWhereOrNull((item) => item.id == id);
  }

  TodoTask getTaskByIndex(int index) {
    return _tasks[index];
  }

  void add(TodoTask task) {
    _tasks.add(task);
    notifyListeners();
  }

  void editTask({required String id, String? title, String? description}) {
    final index = _tasks.indexWhere((element) => element.id == id);
    if (index == -1) {
      return;
    }

    TodoTask oldTask = _tasks[index];
    _tasks[index] = TodoTask(
      id: id,
      title: title ?? oldTask.title,
      description: description ?? oldTask.description,
    );
    notifyListeners();
  }

  void removeTask(TodoTask task) {
    if (_tasks.remove(task)) {
      notifyListeners();
    }
  }

  void completeTask(TodoTask task) {
    if (_tasks.remove(task)) {
      _completedTasks.add(task);
      notifyListeners();
    }
  }
}

@immutable
class TodoTask {
  const TodoTask({
    required this.id,
    this.title = "Untiled Task",
    this.description = "",
  });

  final String id;
  final String title;
  final String description;
}
