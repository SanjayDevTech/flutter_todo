import 'package:uuid/uuid.dart';

var uuid = const Uuid();

String generateId() {
  return uuid.v4();
}
