import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doft/src/presentation/main/home/cubit/home_state.dart';

import '../../../../config/routes/routes.dart';
import '../../../../injector.dart';
import '../../../shared/choose_location_button.dart';
import '../../../shared/load_item.dart';
import '../../../shared/select_truck_type.dart';
import '../cubit/home_cubit.dart';
import '../widgets/add_load.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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
// HomeCubit(instance<RepositoryImpl>())
  final insta = instance<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => insta,
      child: RefreshIndicator(
        onRefresh: () async {
          insta.getloads(isrefresh: true);
        },
        child: Scaffold(
          appBar: _getAppBar(context),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoadingCompeleted &&
                  state.loads.length > 1) {
                return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: state.loads.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // todo : kima add post
                        return Container();
                      } else {
                        return LoadItem(
                          detailsButton: () {
                            if (BlocProvider.of<HomeCubit>(context)
                                    .isFirstTime ==
                                true) {
                              Navigator.popAndPushNamed(
                                  context, Routes.fillProfil);
                            } else {
                              Navigator.pushNamed(context, Routes.loadDetails,
                                  arguments: state.loads[index]);
                            }
                          },
                          load: state.loads[index]!,
                        );
                      }
                    });
              } else if (state is HomeLoadingCompeleted &&
                  state.loads.length <= 1) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No Loads Found , '),
                      TextButton(
                          onPressed: () {
                            insta.getloads(isrefresh: true);
                          },
                          child: const Text('Refresh'))
                    ],
                  ),
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

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      elevation: 4,
      title: ListTile(
          title: const Text(
            'mouvema',
            style: TextStyle(fontSize: 20),
          ),
          trailing: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      String? origin, destination, type;
                      return AlertDialog(
                          title: const Text(
                            'Filter',
                          ),
                          content: SizedBox(
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Origin'),
                                    ChooseLocationButton(
                                        onlocationschanged: (originz) {
                                      origin = originz;
                                    }),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Destination'),
                                    ChooseLocationButton(
                                        onlocationschanged: (destinationz) {
                                      destination = destinationz;
                                    }),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Truck Type'),
                                    SelectTruckType(
                                      onTypeChanged: (typez) {
                                        type = typez;
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel')),
                            ElevatedButton(
                                onPressed: () {
                                  insta.filterLoads(
                                      destination: destination,
                                      origin: origin,
                                      type: type);
                                  Navigator.pop(context);
                                },
                                child: const Text('Search'))
                          ]);
                    });
              },
              icon: const Icon(Icons.filter_alt_outlined, size: 30))),
    );
  }
}
