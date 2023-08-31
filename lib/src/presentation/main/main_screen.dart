import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mouvema/src/presentation/main/home/cubit/home_cubit.dart';
import 'package:mouvema/src/presentation/main/home/cubit/home_state.dart';

import '../../config/routes/routes.dart';

import '../../core/utils/color_manager.dart';
import '../../injector.dart';
import 'home/pages/home_screen.dart';
import 'favorite_loads/pages/favorites_screen.dart';
import 'my_loads/pages/my_loads_screen.dart';
import 'profile/pages/profile_screen.dart';

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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
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
                }),
                //other params
              ),
              // body: GestureDetector(
              //   onHorizontalDragEnd: (details) {
              //     double direction = details.velocity.pixelsPerSecond.dx;

              //     if (direction > 0) {
              //       setState(() {
              //         index = (index - 1) % pages.length;
              //       });
              //     }

              //     if (direction < 0) {
              //       setState(() {
              //         index = (index + 1) % pages.length;
              //       });
              //     }
              //   },
              // child: IndexedStack(
              //   index: index,
              //   children: pages.map((page) {
              //     return AnimatedContainer(
              //       duration: const Duration(milliseconds: 300),
              //       curve: Curves.easeInOut,
              //       child: page,
              //     );
              //   }).toList(),
              // ),
              // ),
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
}
