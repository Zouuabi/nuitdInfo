import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mouvema/src/core/utils/string_manager.dart';
import 'package:mouvema/src/presentation/TransportPublic/pages/TransportPublic.dart';
import 'package:mouvema/src/presentation/main/kanawita/cubit/home_cubit.dart';
import 'package:mouvema/src/presentation/main/kanawita/cubit/home_state.dart';

import '../../config/routes/routes.dart';
import '../../injector.dart';

import '../blog/pages/blog.dart';
import 'kanawita/pages/kanawita.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final pagecontroller = PageController(initialPage: 0);
  final HomeCubit homeCubit = instance<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => instance<HomeCubit>(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Articles'),
                      const Spacer(),
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.teal,
                        ),
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/Profil');
                            },
                            icon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, -1),
                            blurRadius: 2)
                      ]),
                  child: GNav(
                      selectedIndex: index,
                      onTabChange: (val) {
                        setState(() {
                          if (val == 3) {
                            if (BlocProvider.of<HomeCubit>(context)
                                .isFirstTime) {
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      curve: Curves.easeOutExpo,
                      duration: const Duration(milliseconds: 300),
                      gap: 8,
                      color: Colors.grey[800],
                      activeColor: Colors.teal,
                      iconSize: 24,
                      tabBackgroundColor: Colors.teal.withOpacity(0.1),
                      tabs: [
                        GButton(
                          icon: Icons.language,
                          text: StringManager.blog,
                        ),
                        GButton(
                          icon: Icons.emoji_transportation_rounded,
                          text: StringManager.transportaion,
                        ),
                        GButton(
                          icon: Icons.local_shipping_outlined,
                          text: StringManager.kanawita,
                        )
                      ]),
                ),
                body: PageView(
                    controller: pagecontroller,
                    onPageChanged: (value) {
                      setState(() {
                        index = value;
                      });
                    },
                    children: [
                      // MyLoadsScreen(),
                      Feed(),
                      TransportPublic(),
                      Kanawita(),
                    ]));
          },
        ));
  }
}
