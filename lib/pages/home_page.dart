import 'package:flutter/material.dart';
import 'todo_add.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  List<String> _todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("リスト一覧"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(_todoList[index]),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newListText = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodoAdd()),
          );
          if (newListText != null) {
            // 新しいリストの内容を処理する
            setState(() {
              _todoList.add(newListText);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}