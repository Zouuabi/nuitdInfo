import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../data/repository/repository_impl.dart';
import '../../../../injector.dart';
import '../../../shared/load_item.dart';
import '../cubit/favorites_state.dart';
import '../cubit/favorites_cubit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});
  final cubit = FavoritesCubit(repositoryImpl: instance<RepositoryImpl>());
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoritesCubit>(
      create: (context) => cubit,
      child: LiquidPullToRefresh(
        height: 300,
        color: ColorManager.mouvemaTeal,
        backgroundColor: ColorManager.scaffoldBackgroundColor,
        animSpeedFactor: 1,
        onRefresh: () async {
          cubit.getMyFavoritesLoads(refresh: true);
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 4,
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
              } else if (state.status == States.compelted &&
                  state.data!.isEmpty) {
                return const Center(
                  child: Text('Nothing Yet'),
                );
              } else if (state.status == States.error) {
                return Center(
                  child: Text(state.message!),
                );
              } else {
                return Center(child: Text('${state.status}'));
              }
            },
          ),
        ),
      ),
    );
  }
}
