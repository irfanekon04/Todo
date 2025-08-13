import 'package:flutter/material.dart';
import 'package:todo/models/todolist.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/todoscreen.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => Todolist(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: Todoscreen(),
    );
  }
}
