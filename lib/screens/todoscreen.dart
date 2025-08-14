import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/thememodel.dart';
import 'package:todo/models/todolist.dart';

class Todoscreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  Todoscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todolist = context.watch<Todolist>();
    final todos = todolist.sortedTodos;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To-do List",
          // style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeModel>().toggleTheme();
            },
            icon: Icon(
              context.watch<ThemeModel>().isDark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
          ),
        ],
      ),
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
                      border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                FilledButton(
                  // style: FilledButton.styleFrom(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  // ),
                  onPressed: () {
                    final text = _controller.text;

                    if (text.isNotEmpty) {
                      context.read<Todolist>().addTodo(text);
                      _controller.clear();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added Task: $text'),
                          duration: Duration(milliseconds: 800),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  final originalIndex = todolist.todos.indexOf(todo);
                  return Card(
                    // color: Colors.blue[50],
                    child: ListTile(
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (_) {
                          context.read<Todolist>().toggleTodo(originalIndex);
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
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete_rounded,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          final removedTask = todo.title;
                          context.read<Todolist>().removeTodo(originalIndex);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Removed Task: $removedTask'),
                              duration: Duration(milliseconds: 800),
                            ),
                          );
                        },
                      ),
                    ),
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
