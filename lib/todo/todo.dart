import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

import 'package:todo/todo/adapter/todo_adapter.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late final Box<ToDoHive> _todoList = Hive.box<ToDoHive>('todoBox');
  late final TextEditingController _textFieldController;

  @override
  void initState() {
    _textFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: _todoList.values.length,
        itemBuilder: (context, index) {
          final item = _todoList.values.elementAt(index);
          return Dismissible(
            key: Key(item.title),
            onDismissed: (direction) => _deleteItem(index),
            direction: DismissDirection.endToStart,
            background: Container(color: Colors.red),
            child: _buildTodoItem(item.title),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTodoItem(String title) {
    //Wrapping it inside a set state will notify
    // the app that the state has changed

    setState(() {
      _todoList.add(ToDoHive(title: title));
    });
    _textFieldController.clear();
  }

  void _deleteItem(int index) {
    setState(() {
      _todoList.deleteAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item deleted')));
  }

  //Generate list of item widgets
  Widget _buildTodoItem(String title) {
    return ListTile(
      title: Text(title),
    );
  }

  //Generate a single item widget
  void _displayDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a task to your List'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Enter task here'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ADD'),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              },
            ),
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
