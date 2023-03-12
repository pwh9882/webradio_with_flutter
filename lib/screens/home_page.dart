import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        // 제목 디스플레이
        Flexible(
          flex: 3,
          child: Container(
            decoration: const BoxDecoration(color: Colors.grey),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Flexible(
                  flex: 2,
                  child: Center(
                    child: Text(
                      '리스트에서 선택해주세요',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text('라디오'),
                      Text('00.00hz'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // 리스트뷰 라디오 목록
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(color: Colors.blue.shade200),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: 20,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$index'),
                      const Text('00.00hz'),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 1);
              },
            ),
          ),
        ),
        // 재생버튼
        Flexible(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(color: Colors.blueGrey),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(child: SizedBox()),
                IconButton(
                    iconSize: 70,
                    onPressed: () {
                      print("play clicked");
                    },
                    icon: const Icon(Icons.play_circle_fill)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          print("exit clicked");
                        },
                        icon: const Icon(Icons.exit_to_app),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
