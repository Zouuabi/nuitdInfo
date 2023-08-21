import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/routes.dart';
import '../../../../data/repository/repository_impl.dart';
import '../../../../injector.dart';
import '../../../shared/load_item.dart';
import '../cubit/my_loads_cubit.dart';
import '../cubit/my_loads_state.dart';

class MyLoadsScreen extends StatefulWidget {
  const MyLoadsScreen({super.key});

  @override
  State<MyLoadsScreen> createState() => _MyLoadsScreenState();
}

class _MyLoadsScreenState extends State<MyLoadsScreen> {
  List<String> LoadsToDelete = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyLoadsCubit>(
      create: (context) =>
          //repositoryImpl: instance<RepositoryImpl>()
          MyLoadsCubit(instance<RepositoryImpl>()),
      child: BlocBuilder<MyLoadsCubit, MyloadsState>(
        builder: (context, state) {
          if (state.status == States.loading) {
            return Scaffold(
                appBar: AppBar(
                  elevation: 4,
                  title: const Text(
                    'My Laods',
                  ),
                  centerTitle: true,
                ),
                body: const Center(child: CircularProgressIndicator()));
          } else if (state.status == States.complete &&
              state.data!.isNotEmpty) {
            return Scaffold(
                appBar: appBarPosts(context),
                body: RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<MyLoadsCubit>(context)
                        .fetchMyPsots(refresh: true);
                  },
                  child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: state.data!.length,
                      itemBuilder: (context, index) {
                        return LoadItem(
                          longPressed: () {
                            setState(() {
                              if (LoadsToDelete.contains(
                                  state.data![index].loadRef)) {
                                LoadsToDelete.remove(
                                    state.data![index].loadRef);
                              } else {
                                LoadsToDelete.add(state.data![index].loadRef);
                              }
                            });
                          },
                          detailsButton: () {
                            Navigator.pushNamed(context, Routes.loadDetails,
                                arguments: state.data![index]);
                          },
                          load: state.data![index],
                        );
                      }),
                ));
          } else if (state.status == States.complete && state.data!.isEmpty) {
            return Scaffold(
                appBar: AppBar(
                  elevation: 4,
                  title: const Text(
                    'My Laods',
                  ),
                  centerTitle: true,
                ),
                body: const Center(
                  child: Text('Nothing Yet'),
                ));
          } else {
            return const Center(
              child: Text(
                'Something Went Wrong',
              ),
            );
          }
        },
      ),
    );
  }

  AppBar appBarPosts(BuildContext context) {
    return AppBar(
      elevation: 4,
      title: const Text(
        'My Laods',
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              (LoadsToDelete.length != 0)
                  ? showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text('Are you Sure ?'),
                          actions: [
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                    BlocProvider.of<MyLoadsCubit>(context)
                                        .deleteLoads(LoadsToDelete);
                                  },
                                  child: const Text('Delete')),
                            )
                          ],
                        );
                      },
                    )
                  : showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text('Select the loads'),
                          actions: [
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('ok')),
                            )
                          ],
                        );
                      },
                    );
            },
            icon: const Icon(Icons.delete))
      ],
    );
  }
}
