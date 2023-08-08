// ignore_for_file: deprecated_member_use

import 'package:doft/src/config/routes/routes.dart';
import 'package:doft/src/data/data_source/remote_data_source/cloud_firestore.dart';
import 'package:doft/src/data/data_source/remote_data_source/firebase_auth.dart';
import 'package:doft/src/data/data_source/remote_data_source/firebase_storage.dart';
import 'package:doft/src/data/repository/repository_impl.dart';
import 'package:doft/src/presentation/main/post_load/cubits/post_load_cubit.dart';
import 'package:doft/src/presentation/main/post_load/cubits/post_load_state.dart';
import 'package:doft/src/presentation/shared/show_alert.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/map_view.dart';
import '../widgets/details_input.dart';
import '../widgets/hint_text.dart';

class PostLoadScreen extends StatelessWidget {
  const PostLoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<PostCubit>(
        create: (context) {
          return PostCubit(RepositoryImpl(
              auth: FirebaseAuthentication(),
              storage: FirebaseStr(),
              firestore: CloudFiresore()));
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('L form Stateful chaden yed w barra '),
          ),
          body: BlocConsumer<PostCubit, PostState>(
            listener: ((context, state) {
              if (state is PostComplete) {
                showAlert(
                        title: 'Success',
                        message: 'Load Posted',
                        context: context)
                    .then((value) {
                  Navigator.pushReplacementNamed(context, Routes.main);
                });
              } else if (state is PostLoading) {
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
                padding: const EdgeInsets.all(20.0),
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MapView(
                        size: size,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // ** Guiding Text **
                      const HintText(
                          hint:
                              ' Pick the origin and the destination of your load'),
                      const Divider(height: 30),

                      LoadDetailsForm(
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
