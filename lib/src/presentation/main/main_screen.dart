import 'package:flutter/material.dart';

import 'home/pages/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final pagecontroller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
            pagecontroller.jumpToPage(index);
          });
        },
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.teal,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.travel_explore), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
        controller: pagecontroller,
        children: [
          const HomeScreen(),
          Container(
            color: Color.fromARGB(255, 42, 17, 82),
          ),
          Container(
            color: Colors.green,
          )
        ],
      ),
    );
  }
}
