import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todolist.dart';

class Todoscreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  Todoscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todolist = context.watch<Todolist>();
    return Scaffold(
      appBar: AppBar(title: Text("Todo List")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final text = _controller.text;

                    if (text.isNotEmpty) {
                      context.read<Todolist>().addTodo(text);
                      _controller.clear();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added Task: $text')),
                      );
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: todolist.todos.length,
                itemBuilder: (context, index) {
                  final todo = todolist.todos[index];
                  return ListTile(
                    leading: Checkbox(
                      value: todo.isDone,
                      onChanged: (_) {
                        context.read<Todolist>().toggleTodo(index);
                      },
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.isDone
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    onTap: () {
                      final removedTask = todolist.todos[index].title;
                      context.read<Todolist>().removeTodo(index);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Removed Task: $removedTask')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
