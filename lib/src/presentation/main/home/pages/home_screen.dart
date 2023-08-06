import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doft/src/core/dummy_data.dart';
import 'package:doft/src/data/repository/repository_impl.dart';
import 'package:doft/src/domain/repositories/repositories.dart';
import 'package:doft/src/presentation/main/home/pages/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/routes.dart';
import '../../../../data/data_source/remote_data_source/cloud_firestore.dart';
import '../../../../data/data_source/remote_data_source/firebase_auth.dart';
import '../../../../data/data_source/remote_data_source/firebase_storage.dart';
import '../../../../data/models/load.dart';
import '../widgets/load_item.dart';
import 'home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  ///  just tojrab bl statefull widget

  List<Load> loadsList = [];
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListner);
    // fetch firest 10 loads
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListner() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // fetch the next 10 loads
      setState(() {
        // the new 10 load to the old list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(RepositoryImpl(
          auth: FirebaseAuthentication(),
          firestore: CloudFiresore(),
          storage: FirebaseStr())),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: () async {
            /// this is just for debugging
            /// TO Remove later
            await CloudFiresore().postLoad(
              {
                'loaddate': '12/56',
                'pickupdate': '56/6',
                'dropdowndate': '26/15',
                'trucktype': 'stafett',
                'broker': 'hedi',
                'telbroker': '23654159',
                'origin': 'gbeli',
                'destination': 'gafsa',
                'oridinPoint': const GeoPoint(15.65, 14.99),
                'destinationPoint': const GeoPoint(12.33, 11.14),
                'price': '100',
                'weigth': '2500',
                'loadRef': '#254564654',
                'description':
                    'write me a description of the product and the price of the product and the price of the product ',
              },
            );
          },
          child: const Icon(
            Icons.add_road_sharp,
            color: Colors.white,
            size: 40,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(
              seconds: 3,
            ));
          },
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoadingCompeleted) {
                return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(20),
                    itemCount: state.loads.length,
                    itemBuilder: (context, index) {
                      return LoadItem(
                        detailsButton: () {
                          Navigator.pushNamed(context, Routes.loadDetails,
                              arguments: loads);
                        },
                        load: state.loads[index],
                      );
                    });
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
