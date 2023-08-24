// ignore_for_file: deprecated_member_use
import 'package:mouvema/src/presentation/main/post_load/pages/searchMap.dart';

import '../../../../core/helpers/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/routes.dart';
import '../../../../data/repository/repository_impl.dart';
import '../../../../injector.dart';
import 'package:latlong2/latlong.dart';
import '../../../shared/show_alert.dart';
import '../cubits/post_load_cubit.dart';
import '../cubits/post_load_state.dart';
import '../widgets/details_input.dart';
import '../widgets/hint_text.dart';

// ignore: must_be_immutable
class MyLoadsScreen extends StatelessWidget {
  MyLoadsScreen({super.key});
  LatLng? origin;
  LatLng? destination;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCubit>(
        create: (context) {
          return PostCubit(instance<RepositoryImpl>());
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 4,
            title: const Text('Post Load'),
            centerTitle: true,
          ),
          body: BlocConsumer<PostCubit, PostState>(
            listener: ((context, state) {
              if (state.status == Status.success) {
                // TODO : resolve unwanted behavior push replacemen
                // / arrow back is appearing when popoing
                showAlert(
                        title: 'Success',
                        message: 'Load Posted',
                        context: context)
                    .then((value) {
                  Navigator.pushReplacementNamed(context, Routes.main);
                });
              } else if (state.status == Status.success) {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }));
              }
            }),
            builder: (context, state) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(30),
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          height: 200,
                          width: double.infinity,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => MapScreen(
                                          onchange: (p0, p1) {
                                            BlocProvider.of<PostCubit>(context)
                                                .onPositionChanged(p0, p1);
                                          },
                                        )));
                              },
                              icon: Image.asset(
                                'assets/images/map.png',
                              ))),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(height: 30),
                      LoadDetailsForm(
                        origin: (state.status == Status.onPositionChanged)
                            ? state.data![0]
                            : null,
                        destination: (state.status == Status.onPositionChanged)
                            ? state.data![1]
                            : null,
                        onFormSubmited: (load) {
                          BlocProvider.of<PostCubit>(context).postLoad(load);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
