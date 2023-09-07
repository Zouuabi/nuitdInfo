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
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.grey,
                elevation: 4,
                useLegacyColorScheme: true,
                selectedItemColor: Colors.teal,
                unselectedItemColor: ColorManager.mouvemaBrown900,
                selectedLabelStyle: TextStyle(color: Colors.brown),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.work_history),
                    label: 'home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark_outlined),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: '',
                  ),
                ],
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
}
// AnimatedBottomNavigationBar(
//                 iconSize: 25,

//                 // borderColor: ColorManager.mouvemaBrown900,
//                 // borderWidth: 3,
//                 elevation: 2,
//                 splashColor: Colors.teal,

//                 borderWidth: 2,
//                 borderColor: Color.fromARGB(255, 105, 152, 148),
//                 height: 60,
//                 activeColor: ColorManager.mouvemaTeal,
//                 inactiveColor: ColorManager.mouvemaBrown900,

//                 icons: const [
                
//                 ],
//                 activeIndex: index,
//                 gapLocation: GapLocation.center,
//                 notchSmoothness: NotchSmoothness.verySmoothEdge,
//                 leftCornerRadius: 40,
//                 rightCornerRadius: 40,
//                 onTap: (val) => setState(() {
//                   if (val == 3) {
//                     if (BlocProvider.of<HomeCubit>(context).isFirstTime) {
//                       Navigator.pushNamed(context, Routes.fillProfil);
//                     } else {
//                       index = val;
//                       pagecontroller.jumpToPage(index);
//                     }
//                   } else {
//                     index = val;
//                     pagecontroller.jumpToPage(index);
//                   }
//                 }),
//                 //other params
//               ),