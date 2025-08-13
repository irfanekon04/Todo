import 'dart:convert';

class Todo {
  final String title;
  bool isDone;
  Todo(this.title, {this.isDone = false});

  Map<String, dynamic> toMap() {
    return {'title': title, 'isDone': isDone};
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(map['title'], isDone: map['isDone'] ?? false);
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));
}
