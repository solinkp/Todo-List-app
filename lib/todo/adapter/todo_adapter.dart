import 'package:hive/hive.dart';

part 'todo_adapter.g.dart';

@HiveType(typeId: 1, adapterName: 'ToDoAdapter')
class ToDoHive {
  @HiveField(0)
  String title;

  ToDoHive({
    required this.title,
  });
}
