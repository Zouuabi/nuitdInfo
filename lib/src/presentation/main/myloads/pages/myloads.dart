import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/routes.dart';
import '../../../../data/repository/repository_impl.dart';
import '../../../../injector.dart';
import '../../home/widgets/load_item.dart';
import '../cubit/myload_state.dart';
import '../cubit/myloadcubit.dart';

class MyLoads extends StatelessWidget {
  const MyLoads({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyLoadCubit>(
      create: (context) =>
          MyLoadCubit(repositoryImpl: instance<RepositoryImpl>()),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(
              seconds: 3,
            ));
          },
          child: BlocBuilder<MyLoadCubit, MyLoadState>(
            builder: (context, state) {
              if (state.stutes == States.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.stutes == States.compelted) {
                return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: state.data!.length,
                    itemBuilder: (context, index) {
                      return LoadItem(
                        detailsButton: () {
                          Navigator.pushNamed(context, Routes.loadDetails,
                              arguments: state.data![index]);
                        },
                        load: state.data![index],
                      );
                    });
              } else {
                return Center(
                  child: Text(state.message!),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
