import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_todo/data/local/dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'entities.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [TodoEntity])
abstract class AppDatabase extends FloorDatabase {
  TodoDao get todoDao;
}