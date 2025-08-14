import 'todo.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todolist extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Todolist() {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoStrings = prefs.getStringList('todos') ?? [];
    _todos = todoStrings.map((e) => Todo.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoStrings = _todos.map((e) => e.toJson()).toList();
    await prefs.setStringList('todos', todoStrings);
  }

  void addTodo(String title) {
    _todos.add(Todo(title));
    saveTodos();
    notifyListeners();
  }

  void removeTodo(int index) {
    _todos.removeAt(index);
    saveTodos();
    notifyListeners();
  }

  void toggleTodo(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    saveTodos();
    notifyListeners();
  }
}
