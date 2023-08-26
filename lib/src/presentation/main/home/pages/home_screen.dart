import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:mouvema/src/core/utils/color_manager.dart';
import 'package:mouvema/src/presentation/shared/show_alert.dart';

import '../../../../config/routes/routes.dart';
import '../../../../injector.dart';
import '../../../shared/choose_location_button.dart';
import '../../../shared/load_item.dart';
import '../../../shared/select_truck_type.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      create: (context) => instance<HomeCubit>(),
      child: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        height: 300,
        color: ColorManager.mouvemaTeal,
        backgroundColor: ColorManager.scaffoldBackgroundColor,
        animSpeedFactor: 1,
        onRefresh: () async {
          instance<HomeCubit>().fetchLoads(isrefresh: true);
        },
        child: BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
          if (state.status == Status.fetchFailed) {
            showAlert(
                message: state.errorMessage!, context: context, title: 'Error');
          }
        }, builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return CustomScrollView(
              controller: ScrollController(),
              slivers: [
                const AppBarz(),
                SliverList.builder(
                    itemCount: state.data!.length,
                    itemBuilder: (context, index) {
                      checkAuthenticity() {
                        if (BlocProvider.of<HomeCubit>(context).isFirstTime) {
                          Navigator.pushNamed(context, Routes.fillProfil);
                        } else {
                          Navigator.pushNamed(context, Routes.loadDetails,
                              arguments: state.data![index]);
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: LoadItem(
                            onPressed: () {
                              checkAuthenticity();
                            },
                            longPressed: () {},
                            load: state.data![index],
                            detailsButton: () {
                              checkAuthenticity();
                            }),
                      );
                    })
              ],
            );
          }
        }),
      ),
    );
  }
}
