import 'package:doft/src/presentation/main/my_loads/my_loads_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home/pages/home_screen.dart';
import 'favorite_loads/pages/favorites_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final pagecontroller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _getBottomNavigationBar(),
      body: SafeArea(
        child: PageView(
          onPageChanged: (value) {
            setState(() {
              index = value;
            });
          },
          controller: pagecontroller,
          children: [
            const HomeScreen(),
            const MyLoadsScreen(),
            const FavoritesScreen(),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text('Log out')),
            )
          ],
        ),
      ),
    );
  }

  Container _getBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 20, spreadRadius: 1),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.red,
        iconSize: 40,
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
          BottomNavigationBarItem(icon: Icon(Icons.work_history), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
