import 'package:flutter/material.dart';
import 'todo_add.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("リスト一覧"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            Card(
              child: ListTile(
                title: Text("リスト1"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("リスト2"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("リスト3"),
              ),
            ),
          ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodoAdd()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}