import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:todo/signin/signin_screen.dart';
import 'package:todo/todo/adapter/todo_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  runApp(App());
}

Future<void> _initHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  /// Register adapter
  Hive.registerAdapter<ToDoHive>(ToDoAdapter());

  /// Open box
  await Hive.openBox<ToDoHive>('todoBox');
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do-List',
      home: SignInScreen(),
    );
  }
}
