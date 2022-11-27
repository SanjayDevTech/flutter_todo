import 'package:floor/floor.dart';
import "package:flutter/material.dart";
import 'package:flutter_todo/data/convertor.dart';
import 'package:flutter_todo/data/local/app_database.dart';
import 'package:flutter_todo/data/local/data_inherited.dart';

import 'package:flutter_todo/screens/home/main.dart';
import 'package:flutter_todo/utils.dart';

import 'data/local/entities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDatabase
        .databaseBuilder('todo_database.db')
        .addCallback(Callback(
          onCreate: (db, version) {
            db.insert("TodoEntity", TodoEntity(generateId(), "Hello", "Hello World", false).map);
          }
        ))
        .build();

  runApp(DataInherited(
    todoDao: database.todoDao,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
