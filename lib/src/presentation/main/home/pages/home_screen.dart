import 'dart:async';

import 'package:doft/src/core/internet_checker.dart';
import 'package:doft/src/data/data_source/local_data_source/local_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doft/src/presentation/main/home/cubit/home_state.dart';

import '../../../../config/routes/routes.dart';
import '../../../../data/data_source/remote_data_source/cloud_firestore.dart';
import '../../../../data/data_source/remote_data_source/firebase_auth.dart';
import '../../../../data/data_source/remote_data_source/firebase_storage.dart';
import '../../../../data/repository/repository_impl.dart';
import '../../../../injector.dart';
import '../cubit/home_cubit.dart';
import '../widgets/load_item.dart';

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


  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(RepositoryImpl(
        localStorage: LocalStorage(),        internetChecker: InternetCheckerImpl(),
          auth: FirebaseAuthentication(),
          firestore: CloudFiresore(),
          storage: CloudStorage())),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: () async {
            Navigator.pushNamed(context, Routes.postLoad);
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
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoadingCompeleted) {
                return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: state.loads.length,
                    itemBuilder: (context, index) {
                      return LoadItem(
                        detailsButton: () {
                          Navigator.pushNamed(context, Routes.loadDetails,
                              arguments: state.loads[index]);
                        },
                        load: state.loads[index],
                      );
                    });
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
