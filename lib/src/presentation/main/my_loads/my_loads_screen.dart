import 'package:doft/src/data/repository/repository_impl.dart';
import 'package:doft/src/presentation/main/my_loads/my_loads_cubit.dart';
import 'package:doft/src/presentation/main/my_loads/my_loads_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/routes.dart';
// import '../../../data/repository/repository_impl.dart';
// import '../../../injector.dart';
import '../../../injector.dart';
import '../../shared/load_item.dart';

class MyLoadsScreen extends StatelessWidget {
  const MyLoadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyLoadsCubit>(
      create: (context) =>
          //repositoryImpl: instance<RepositoryImpl>()
          MyLoadsCubit(instance<RepositoryImpl>()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: const Text(
            'My Laods',
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<MyLoadsCubit, MyloadsState>(
          builder: (context, state) {
            if (state.status == States.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == States.complete &&
                state.data!.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<MyLoadsCubit>(context)
                      .fetchMyLoads(refresh: true);
                },
                child: ListView.builder(
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
                    }),
              );
            } else if (state.status == States.complete && state.data!.isEmpty) {
              return const Center(
                child: Text('Nothing Yet'),
              );
            } else {
              return const Center(
                child: Text(
                  'Something Went Wrong',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
