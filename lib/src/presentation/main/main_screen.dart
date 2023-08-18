import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../config/routes/routes.dart';
import '../../core/utils/colors_manager.dart';
import 'home/pages/home_screen.dart';
import 'favorite_loads/pages/favorites_screen.dart';
import 'my_loads/my_loads_screen.dart';
import 'profile/pages/profile_screen.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.postLoad);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        iconSize: 35,
        backgroundColor: const Color.fromARGB(255, 216, 233, 231),

        // borderColor: ColorManager.mouvemaBrown900,
        // borderWidth: 3,
        elevation: 2,
        borderWidth: 5,
        borderColor: Colors.teal,
        height: 70,
        activeColor: Colors.teal,
        inactiveColor: ColorManager.mouvemaBrown900,

        icons: const [
          Icons.home,
          Icons.work_history,
          Icons.bookmark_outlined,
          Icons.person
        ],
        activeIndex: index,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (val) => setState(() {
          index = val;
          pagecontroller.jumpToPage(index);
        }),
        //other params
      ),
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
        controller: pagecontroller,
        children: [
          HomeScreen(),
          const MyLoadsScreen(),
          const FavoritesScreen(),
          const ProfileScreen()
        ],
      ),
    );
  }

  Container _getBottomNavigationBar() {
    return Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 10),
          ],
        ),
        child: BottomNavigationBar(
          iconSize: 40,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
              pagecontroller.jumpToPage(index);
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.work_history), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outlined), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ],
        ));
  }
  // DotNavigationBar(
  //     currentIndex: index,
  //     onTap: (val) {
  //       setState(() {
  //         index = val;
  //       });
  //     },
  //     // dotIndicatorColor: Colors.black,
  //     items: [
  //       /// Home
  //       DotNavigationBarItem(
  //         icon: Icon(Icons.home),
  //         selectedColor: Colors.purple,
  //       ),

  //       /// Likes
  //       DotNavigationBarItem(
  //         icon: Icon(Icons.favorite_border),
  //         selectedColor: Colors.pink,
  //       ),

  //       /// Search
  //       DotNavigationBarItem(
  //         icon: Icon(Icons.search),
  //         selectedColor: Colors.orange,
  //       ),

  //       /// Profile
  //       DotNavigationBarItem(
  //         icon: Icon(Icons.person),
  //         selectedColor: Colors.teal,
  //       ),
  //     ],
  //   ),

  // SalomonBottomBar(
  //       currentIndex: index,
  //       onTap: (i) => setState(() {
  //         index = i;
  //         pagecontroller.jumpToPage(index);
  //       }),
  //       items: [
  //         /// Home
  //         SalomonBottomBarItem(
  //           icon: Icon(Icons.home),
  //           title: Text("Home"),
  //         ),

  //         /// Likes
  //         SalomonBottomBarItem(
  //           icon: Icon(Icons.favorite_border),
  //           title: Text("Likes"),
  //         ),

  //         /// Search
  //         SalomonBottomBarItem(
  //           icon: Icon(Icons.search),
  //           title: Text("Search"),
  //         ),

  //         /// Profile
  //         SalomonBottomBarItem(
  //           icon: Icon(Icons.person),
  //           title: Text("Profile"),
  //         ),
  //       ],
  //     ),
}
