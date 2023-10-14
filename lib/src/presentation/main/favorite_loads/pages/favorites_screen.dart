import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:mouvema/src/data/repository/repository_impl.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../injector.dart';
import '../../../shared/load_item.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  // final cubit = FavoritesCubit(repositoryImpl: instance<RepositoryImpl>());
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoritesCubit>(
      create: (context) =>
          FavoritesCubit(repositoryImpl: instance<RepositoryImpl>()),
      child: LiquidPullToRefresh(
        height: 300,
        color: ColorManager.mouvemaTeal,
        backgroundColor: ColorManager.scaffoldBackgroundColor,
        animSpeedFactor: 3,
        onRefresh: () async {
          // FavoritesCubit(repositoryImpl: instance<RepositoryImpl>())
          //     .getMyFavoritesLoads(refresh: true);
        },
        child: Scaffold(
          appBar: AppBar(
            leading: null,
            elevation: 4,
            title: const Text(
              'My Favorite Posts',
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              if (state.status == Status.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == Status.success &&
                  state.data!.isNotEmpty) {
                return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: state.data!.length,
                    itemBuilder: (context, index) {
                      return LoadItem(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.loadDetails,
                              arguments: state.data![index]);
                        },
                        longPressed: () {},
                        detailsButton: () {
                          Navigator.pushNamed(context, Routes.loadDetails,
                              arguments: state.data![index]);
                        },
                        load: state.data![index],
                      );
                    });
              } else if (state.status == Status.success &&
                  state.data!.isEmpty) {
                return const Center(
                  child: Text('No loads added to favorites'),
                );
              } else {
                return Center(
                    child: Text(state.message ?? 'Something went wrong'));
              }
            },
          ),
        ),
      ),
    );
  }
}
