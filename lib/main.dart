import 'package:flutter/material.dart';
import 'package:todo/models/tememodel.dart';
import 'package:todo/models/todolist.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/todoscreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Todolist()),
        ChangeNotifierProvider(create: (_) => Thememodel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<Thememodel>();
    return MaterialApp(
      title: 'Todo List',
      themeMode: themeModel.currentTheme,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
        // cardTheme: CardThemeData(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        // ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      home: Todoscreen(),
    );
  }
}
