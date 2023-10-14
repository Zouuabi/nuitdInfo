import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:mouvema/src/core/utils/color_manager.dart';
import 'package:mouvema/src/core/utils/string_manager.dart';

import '../../../../config/routes/routes.dart';
import '../../../../injector.dart';
import '../../../shared/load_item.dart';
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
    return LiquidPullToRefresh(
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
          AwesomeDialog(
            btnOkColor: Colors.teal,
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: StringManager.error,
          ).show();
        }
      }, builder: (context, state) {
        if (state.status == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == Status.fetchSuccess) {
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

                    return LoadItem(
                        onPressed: () {
                          checkAuthenticity();
                        },
                        longPressed: () {},
                        load: state.data![index],
                        detailsButton: () {
                          checkAuthenticity();
                        });
                  })
            ],
          );
        } else {
          return Center(
            child: Text(state.errorMessage ?? 'Something went Wrong'),
          );
        }
      }),
    );
  }
}
