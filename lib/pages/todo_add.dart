import "package:flutter/material.dart";

class TodoAdd extends StatefulWidget {
  const TodoAdd({super.key});

  @override
  State<TodoAdd> createState() => _TodoAddState();
}

class _TodoAddState extends State<TodoAdd> {
  String _Text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("リスト追加"),
      ),
      body: Container(
        padding: const EdgeInsets.all(64.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_Text,
            style: const TextStyle(
              fontSize: 24,
            ),
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "リストの内容を入力してください",
              ),
              onChanged: (String value) {
                setState(() {
                  _Text = value;
                });
              },
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _Text);
                },
                child: const Text("リスト追加",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("キャンセル"),
              ),
            ),
          ],
          )
      ),
    );
  }
}