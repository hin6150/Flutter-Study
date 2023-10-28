import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/screens/add_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> tapLocation = [1, 1, 1, 1];
  bool isTap = false;

  void onTap(int index) {
    setState(() {
      if (!isTap) {
        isTap = true;
      }
      tapLocation = [1, 1, 1, 1];
      tapLocation[index] = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFF8181),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          TodoCategory(
            category: "To Do",
            description: 'Urgent, Important Things.',
            bgColor: const Color(0xffFF8181),
            fontColor: const Color(0xffD0F4A4),
            flex: tapLocation[0],
            onTap: () => onTap(0),
            isTap: isTap,
          ),
          TodoCategory(
            category: "To Schedule",
            description: 'Not Urgent, Important Things.',
            bgColor: const Color(0xffFCE38A),
            fontColor: const Color(0xff6677bb),
            flex: tapLocation[1],
            onTap: () => onTap(1),
            isTap: isTap,
          ),
          TodoCategory(
            category: "To Delegate",
            description: "Urgent, Not Important Things.",
            bgColor: const Color(0xffEAFFD0),
            fontColor: const Color(0xffD297F3),
            flex: tapLocation[2],
            onTap: () => onTap(2),
            isTap: isTap,
          ),
          TodoCategory(
            category: "To Delete",
            description: "Not Urgent, Not Important Things.",
            bgColor: const Color(0xff95E1D3),
            fontColor: const Color(0xffE27C7F),
            flex: tapLocation[3],
            onTap: () => onTap(3),
            isTap: isTap,
          ),
        ],
      ),
    );
  }
}

class TodoCategory extends StatelessWidget {
  final String category, description;
  final Color bgColor, fontColor;
  final int flex;
  final VoidCallback onTap;
  final bool isTap;

  const TodoCategory({
    super.key,
    required this.category,
    required this.description,
    required this.bgColor,
    required this.fontColor,
    required this.flex,
    required this.onTap,
    required this.isTap,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(color: bgColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category,
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 32,
                        fontFamily: 'Jalnan',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddScreen(),
                            fullscreenDialog: true,
                          ),
                        )
                      },
                      child: Icon(
                        category == 'To Do' ? Icons.add_outlined : null,
                        color: fontColor,
                        size: 32,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<TodoController>(
                  init: TodoController(),
                  builder: (controller) => Column(
                    children:
                        controller.instance.categories.keys.map((category) {
                      List<TodoItem> itemList =
                          controller.instance.categories[category]!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...itemList.map((item) => Text(item.text)),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
