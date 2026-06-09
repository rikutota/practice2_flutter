import "package:flutter_riverpod/flutter_riverpod.dart" ;

class TodoListNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return [];
  }

  void addTodo(String todo) {
    state = [...state, todo];
  }
}

final todoListProvider = NotifierProvider<TodoListNotifier, List<String>>(() {
  return TodoListNotifier();
});