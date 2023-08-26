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
  List<String> loadsToDelete = [];

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
                appBar: _appBar(context),
                body: RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<MyLoadsCubit>(context)
                        .fetchMyLoads(refresh: true);
                  },
                  child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: state.data!.length,
                      itemBuilder: (context, index) {
                        return LoadItem(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.loadDetails,
                                arguments: state.data![index]);
                          },
                          longPressed: () {
                            setState(() {
                              if (loadsToDelete
                                  .contains(state.data![index].loadRef)) {
                                loadsToDelete
                                    .remove(state.data![index].loadRef);
                              } else {
                                loadsToDelete.add(state.data![index].loadRef);
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
            return Scaffold(
              appBar: AppBar(title: const Text('My Posts')),
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
                    child: Text(state.message!),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 4,
      title: const Text(
        'My Laods',
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              (loadsToDelete.isNotEmpty)
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
                                        .deleteLoads(loadsToDelete);
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
