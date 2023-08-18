import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/routes.dart';
import '../../../../data/repository/repository_impl.dart';
import '../../../../injector.dart';
import '../../../shared/load_item.dart';
import '../cubit/favorites_state.dart';
import '../cubit/favorites_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoritesCubit>(
      create: (context) =>
          FavoritesCubit(repositoryImpl: instance<RepositoryImpl>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Favorite Posts',
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state.status == States.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == States.compelted &&
                state.data!.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<FavoritesCubit>(context)
                      .getMyLoads(refresh: true);
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
            } else if (state.status == States.compelted &&
                state.data!.isEmpty) {
              return const Center(
                child: Text('Nothing Yet'),
              );
            } else {
              return Center(
                child: Text(state.message!),
              );
            }
          },
        ),
      ),
    );
  }
}
