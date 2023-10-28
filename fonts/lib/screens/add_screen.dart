import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:todo_list/models/todo_item.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String _selectedValue = '';
  Color _selectedBgColor = const Color(0xffC8C8C8);
  Color _selectedFontColor = const Color(0xff000000);

  @override
  Widget build(BuildContext context) {
    TodoController todoController = Get.find<TodoController>();

    return Scaffold(
      backgroundColor: _selectedBgColor,
      appBar: AppBar(
        backgroundColor: _selectedBgColor,
        foregroundColor: _selectedFontColor,
        elevation: 0,
        title: const Text('Create Todo'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 2,
            color: _selectedFontColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What to do?',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "Jalnan",
                  color: _selectedFontColor,
                ),
              ),
              const TextField(),
              const SizedBox(
                height: 40,
              ),
              Text(
                'How important it is?',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "Jalnan",
                  color: _selectedFontColor,
                ),
              ),
              todoRow(
                title: 'To Do',
                description: 'Urgent, Important Things.',
                fontColor: const Color(0xffD0F4A4),
                bgColor: const Color(0xffFF8181),
              ),
              todoRow(
                title: 'To Schedule',
                description: 'Not Urgent, Important Things.',
                bgColor: const Color(0xffFCE38A),
                fontColor: const Color(0xff6677bb),
              ),
              todoRow(
                title: 'To Delegate',
                description: 'Urgent, Not Important Things.',
                bgColor: const Color(0xffEAFFD0),
                fontColor: const Color(0xffD297F3),
              ),
              todoRow(
                title: 'To Delete',
                description: 'Not Urgent, Not Important Things.',
                bgColor: const Color(0xff95E1D3),
                fontColor: const Color(0xffE27C7F),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        todoController.addTodoItem(
                          _selectedValue,
                          0,
                          false,
                          false,
                          "Test1",
                        );

                        Navigator.pop(context);
                      },
                      style: const ButtonStyle(),
                      child: Text(
                        'Create',
                        style: TextStyle(
                          color: _selectedFontColor,
                          fontFamily: "Jalnan",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector todoRow({
    required String title,
    required String description,
    required Color fontColor,
    required Color bgColor,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBgColor = bgColor;
          _selectedFontColor = fontColor;
          _selectedValue = title;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    color: _selectedValue == title ? fontColor : Colors.black,
                    fontFamily: "Jalnan",
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: _selectedValue == title ? fontColor : Colors.black,
                  ),
                ),
              ],
            ),
            Radio(
              value: title,
              activeColor: fontColor,
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value.toString();
                  _selectedBgColor = bgColor;
                  _selectedFontColor = fontColor;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
