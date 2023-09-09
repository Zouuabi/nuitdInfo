import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mouvema/src/presentation/main/home/cubit/home_cubit.dart';
import 'package:mouvema/src/presentation/main/home/cubit/home_state.dart';

import '../../config/routes/routes.dart';

import '../../injector.dart';
import 'home/pages/home_screen.dart';
import 'favorite_loads/pages/favorites_screen.dart';
import 'my_loads/pages/my_loads_screen.dart';
import 'profile/pages/profile_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final pagecontroller = PageController(initialPage: 0, keepPage: true);
  final pages = const [
    HomeScreen(),
    MyLoadsScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => instance<HomeCubit>(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (BlocProvider.of<HomeCubit>(context).isFirstTime) {
                    Navigator.pushNamed(context, Routes.fillProfil);
                  } else {
                    Navigator.pushReplacementNamed(context, Routes.postLoad);
                  }
                },
                child: const Icon(Icons.add),
              ),
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, -1),
                          blurRadius: 2)
                    ]),
                child: GNav(
                    onTabChange: (val) {
                      setState(() {
                        if (val == 3) {
                          if (BlocProvider.of<HomeCubit>(context).isFirstTime) {
                            Navigator.pushNamed(context, Routes.fillProfil);
                          } else {
                            index = val;
                            pagecontroller.jumpToPage(index);
                          }
                        } else {
                          index = val;
                          pagecontroller.jumpToPage(index);
                        }
                      });
                    },
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    curve: Curves.easeOutExpo,
                    duration: const Duration(milliseconds: 300),
                    gap: 8,
                    color: Colors.grey[800],
                    activeColor: Colors.teal,
                    iconSize: 24,
                    tabBackgroundColor: Colors.teal.withOpacity(0.1),
                    tabs: const [
                      GButton(
                        icon: Icons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.work_history_outlined,
                        text: 'My loads',
                      ),
                      GButton(
                        icon: Icons.bookmark_border,
                        text: 'favorites',
                      ),
                      GButton(
                        icon: Icons.person_4_outlined,
                        text: 'Profile',
                      )
                    ]),
              ),
              body: PageView.builder(
                  controller: pagecontroller,
                  itemCount: 4,
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return pages[index];
                  }),
            );
          },
        ));
  }


  Container _getBottomNavigationBar() {
    return Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 10),
          ],
        ),
        child: BottomNavigationBar(
          iconSize: 30,
          currentIndex: index,
          onTap: (value) {
            setState(() {});
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

}
