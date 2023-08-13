import 'dart:async';

import 'package:doft/src/data/repository/repository_impl.dart';
import 'package:doft/src/presentation/main/post_load/pages/post_load_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doft/src/presentation/main/home/cubit/home_state.dart';

import '../../../../config/routes/routes.dart';

import '../../../../injector.dart';
import '../../../shared/choose_location_button.dart';
import '../../../shared/select_truck_type.dart';
import '../cubit/home_cubit.dart';
import '../../../shared/load_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // final ScrollController _scrollController = ScrollController();

  ///  just tojrab bl statefull widget

  // List<Load> loadsList = [];
  // @override
  // void initState() {
  //   super.initState();
  //   _scrollController.addListener(_scrollListner);
  //   // fetch firest 10 loads
  // }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  // void _scrollListner() {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     // fetch the next 10 loads
  //     setState(() {
  //       // the new 10 load to the old list
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(instance<RepositoryImpl>()),
      child: Scaffold(
        appBar: AppBar(
          title: ListTile(
              title: const Text(
                'mouvema',
                style: TextStyle(fontSize: 20),
              ),
              trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          String origin, destination, type;
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 100),
                            child: AlertDialog(
                                title: const Text(
                                  'Filter',
                                ),
                                content: Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 250,
                                      child: ChooseLocationButton(
                                          onlocationschanged: (origin) {}),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 250,
                                      child: ChooseLocationButton(
                                          onlocationschanged: (destination) {}),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 250,
                                      child: SelectTruckType(
                                        onTypeChanged: (type) {},
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel')),
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Search'))
                                ]),
                          );
                        });
                  },
                  icon: const Icon(Icons.filter_alt_outlined, size: 30))),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(
              seconds: 3,
            ));
          },
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoadingCompeleted &&
                  state.loads.isNotEmpty) {
                return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: state.loads.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // todo : kima add post
                        return SizedBox(
                          height: 60,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  iconSize: MaterialStateProperty.all(30),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.teal)),
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.postLoad);
                              },
                              icon: const Icon(Icons.add_road),
                              label: const Text(
                                'Add a Post',
                                style: TextStyle(fontSize: 20),
                              )),
                        );
                      } else {
                        return LoadItem(
                          detailsButton: () {
                            Navigator.pushNamed(context, Routes.loadDetails,
                                arguments: state.loads[index]);
                          },
                          load: state.loads[index]!,
                        );
                      }
                    });
              } else if (state is HomeLoadingCompeleted &&
                  state.loads.isEmpty) {
                return const Center(
                  child: Text('No Loads Yet'),
                );
              } else {
                state as HomeError;
                return Center(
                  child: Text(state.message),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
