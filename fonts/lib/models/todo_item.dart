import 'package:get/get_state_manager/get_state_manager.dart';

class TodoItem {
  final num id;
  final bool isCheck, isStar;
  final String text;

  TodoItem({
    required this.id,
    required this.isCheck,
    required this.isStar,
    required this.text,
  });
}

class TodoList {
  final Map<String, List<TodoItem>> categories;

  TodoList({
    required this.categories,
  });

  // 카테고리에 아이템 추가 메서드
  void addItem(String category, TodoItem newItem) {
    if (categories.containsKey(category)) {
      categories[category]!.add(newItem);
    } else {
      // Handle the case where an invalid category is provided
      print('Invalid category: $category');
    }
  }
}

class TodoController extends GetxController {
  TodoController();

  TodoList instance = TodoList(
    categories: {
      'To Do': [],
      'To Schedule': [],
      'To Delegate': [],
      'To Delete': [],
    },
  );

  // 예제 함수
  void addTodoItem(
      String category, num id, bool isCheck, bool isStar, String text) {
    TodoItem newItem =
        TodoItem(id: id, isCheck: isCheck, isStar: isStar, text: text);
    instance.addItem(category, newItem);
    update(); // 상태 변경을 알립니다.
  }
}
