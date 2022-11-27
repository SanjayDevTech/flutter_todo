import 'package:flutter_todo/data/local/entities.dart';

import 'models.dart';

extension TodoConvertor on Todo {
  TodoEntity get entity {
    return TodoEntity(id, title, description, completed);
  }
}

extension TodoEntityConvertor on TodoEntity {
  Todo get model {
    return Todo(id: id, title: title, description: description, completed: completed);
  }

  Map<String, dynamic> get map {
    return {
      "id": id,
      "title": title,
      "description": description,
      "completed": completed ? 1 : 0,
    };
  }
}