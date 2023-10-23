import 'package:flutter/material.dart';
import 'package:todo_list/screens/add_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffFF8181),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          TodoCategory(
            category: "To Do",
            bgColor: Color(0xffFF8181),
            fontColor: Color(0xffD0F4A4),
          ),
          TodoCategory(
            category: "To Schedule",
            bgColor: Color(0xffFCE38A),
            fontColor: Color(0xff6677bb),
          ),
          TodoCategory(
            category: "To Delegate",
            bgColor: Color(0xffEAFFD0),
            fontColor: Color(0xffD297F3),
          ),
          TodoCategory(
            category: "To Delete",
            bgColor: Color(0xff95E1D3),
            fontColor: Color(0xffE27C7F),
          ),
        ],
      ),
    );
  }
}

class TodoCategory extends StatelessWidget {
  final String category;
  final Color bgColor, fontColor;

  const TodoCategory({
    super.key,
    required this.category,
    required this.bgColor,
    required this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
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
                        color: fontColor, fontSize: 32, fontFamily: 'Jalnan'),
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
              Column(
                children: [
                  Text(
                    'data',
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
