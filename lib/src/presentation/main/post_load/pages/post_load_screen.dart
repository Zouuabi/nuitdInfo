// ignore_for_file: deprecated_member_use
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mouvema/src/presentation/main/post_load/pages/searchMap.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/presentation/main/post_load/widgets/hint_text.dart';
import '../../../../config/routes/routes.dart';
import '../../../../data/repository/repository_impl.dart';
import '../../../../injector.dart';
import 'package:latlong2/latlong.dart';
import '../../../shared/show_alert.dart';
import '../cubits/post_load_cubit.dart';
import '../cubits/post_load_state.dart';
import '../widgets/details_input.dart';

// ignore: must_be_immutable
class PostLoadScreen extends StatelessWidget {
  PostLoadScreen({super.key});
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
                AwesomeDialog(
                    btnOkColor: Colors.teal,
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.topSlide,
                    title: 'Load Posted',
                    btnOkOnPress: () {
                      Navigator.pushReplacementNamed(context, Routes.main);
                    }).show();
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
                        height: 5,
                      ),
                      const HintText(
                          hint: 'Pick the origin and the destination'),
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
