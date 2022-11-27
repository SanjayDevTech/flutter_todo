import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/data/local/dao.dart';

class DataInherited extends InheritedWidget {
  final TodoDao todoDao;

  const DataInherited({super.key, required this.todoDao, required super.child});

  static DataInherited of(BuildContext context) {
    final dataInherited =  (context.dependOnInheritedWidgetOfExactType<DataInherited>());
    if (dataInherited == null) {
      throw Exception("DataInherited is not found in the hierarchy");
    }
    return dataInherited;
  }
  
  @override
  bool updateShouldNotify(covariant DataInherited oldWidget) {
    return false;
  }
}
