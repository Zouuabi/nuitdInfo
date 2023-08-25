import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:mouvema/src/core/utils/color_manager.dart';

import '../../../../config/routes/routes.dart';
import '../../../../injector.dart';
import '../../../shared/choose_location_button.dart';
import '../../../shared/load_item.dart';
import '../../../shared/select_truck_type.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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

  final homeCubit = instance<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    // todo : view details problem
    return BlocProvider<HomeCubit>(
      create: (context) => homeCubit,
      child: LiquidPullToRefresh(
          height: 300,
          color: ColorManager.mouvemaTeal,
          backgroundColor: ColorManager.scaffoldBackgroundColor,
          animSpeedFactor: 1,
          onRefresh: () async {
            homeCubit.fetchLoads(isrefresh: true);
          },
          child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.status == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == Status.fetchSuccess) {
                  return CustomScrollView(
                    controller: ScrollController(),
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        elevation: 10,
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      const Text('Origin'),
                                                      ChooseLocationButton(
                                                          onlocationschanged:
                                                              (originz) {
                                                        origin = originz;
                                                      }),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      const Text('Destination'),
                                                      ChooseLocationButton(
                                                          onlocationschanged:
                                                              (destinationz) {
                                                        destination =
                                                            destinationz;
                                                      }),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
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
                                                    homeCubit.filterLoads(
                                                        destination:
                                                            destination,
                                                        origin: origin,
                                                        type: type);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Search'))
                                            ]);
                                      });
                                },
                                icon: const Icon(Icons.filter_alt_outlined,
                                    size: 30))),
                      ),
                      SliverList.builder(
                          itemCount: state.data!.length,
                          itemBuilder: (context, index) {
                            return LoadItem(
                                load: state.data![index],
                                detailsButton: () {
                                  if (BlocProvider.of<HomeCubit>(context)
                                      .isFirstTime) {
                                    Navigator.pushNamed(
                                        context, Routes.fillProfil);
                                  } else {
                                    Navigator.pushNamed(
                                        context, Routes.loadDetails,
                                        arguments: state.data![index]);
                                  }
                                });
                          })
                    ],
                  );
                } else {
                  return Scaffold(
                    appBar: AppBar(title: const Text('mouvema')),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Image.asset(
                          'assets/images/warning.png',
                          width: 50,
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(state.errorMessage!),
                        ),
                      ],
                    ),
                  );
                }
              })),
    );
  }
}
