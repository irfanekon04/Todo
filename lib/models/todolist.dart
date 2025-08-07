import 'todo.dart';
import 'package:flutter/foundation.dart';

class Todolist extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(String title) {
    _todos.add(Todo(title));
    notifyListeners();
  }

  void removeTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  void toggleTodo(int index) {
    _todos[index].isDone = ! _todos[index].isDone;
    notifyListeners();
  }
}
