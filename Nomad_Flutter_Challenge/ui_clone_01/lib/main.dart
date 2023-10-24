import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(31, 173, 173, 173),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: Image.network(
                        'https://i.pinimg.com/564x/78/0e/2c/780e2c3620a5982a829b3d3e9f1bfea0.jpg',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    const Icon(
                      Icons.add_outlined,
                      color: Colors.white,
                      size: 40,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "TUESDAY 24",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        "TODAY",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                        ),
                      ),
                      Text(
                        "·",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 100,
                        ),
                      ),
                      Text(
                        "25  26  27  28  29  30  31",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 38,
                        ),
                      ),
                    ],
                  ),
                ),
                CardWidget(
                  color: Colors.yellow.shade400,
                  text: "DESIGN MEETING",
                  names: const ["ALEX", "HELENA", "NANA"],
                  startTime: const ["11", "30"],
                  endTime: const ["12", "20"],
                ),
                CardWidget(
                  color: Colors.purple.shade200,
                  text: "DAILY PROJECT",
                  names: const ["ME", "RICHARD", "CIRY", "+4"],
                  startTime: const ["12", "35"],
                  endTime: const ["14", "10"],
                ),
                CardWidget(
                  color: Colors.green.shade200,
                  text: "WEEKLY PLANNING",
                  names: const ["DEN", "NANA", "MARK"],
                  startTime: const ["15", "00"],
                  endTime: const ["16", "30"],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final Color color;
  final String text;
  final List<String> names, startTime, endTime;

  const CardWidget({
    super.key,
    required this.color,
    required this.text,
    required this.names,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 15,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    startTime[0],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(startTime[1]),
                  const SizedBox(
                    height: 25.0,
                    child: VerticalDivider(
                      color: Colors.black, // 선의 색상
                      thickness: 1.0, // 선의 두께
                    ),
                  ),
                  Text(
                    endTime[0],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(endTime[1]),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: names
                          .map((data) => Text(
                                data,
                                style: TextStyle(
                                  color: data == "ME"
                                      ? Colors.black
                                      : Colors.black54,
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
