import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/core/utils/string_manager.dart';

import '../../../config/routes/routes.dart';
import '../../../core/utils/image_manager.dart';
import '../../../data/repository/repository_impl.dart';
import '../../../injector.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginScreenCubit(instance<RepositoryImpl>()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: BlocConsumer<LoginScreenCubit, LoginScreenState>(
            listener: (context, state) {
              if (state.status == Status.failed) {
                AwesomeDialog(
                        btnOkColor: Colors.teal,
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.topSlide,
                        title: 'Erreur',
                        desc: state.errorMessage)
                    .show();
              } else if (state.status == Status.success) {
                Navigator.pushReplacementNamed(context, Routes.main);
              }
            },
            builder: (context, state) {
              if (state.status == Status.loading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  children: [
                    const Spacer(),
                    Expanded(
                        flex: 3, child: Image.asset(ImageManager.logoWithName)),
                    const Spacer(),
                    Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 60,
                                child: OutlinedButton.icon(
                                    icon: const Icon(Icons.key, size: 40),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, Routes.loginWithPassword);
                                    },
                                    label: Text(
                                      StringManager.loginToYourAccount,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    )),
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                height: 60,
                                child: OutlinedButton.icon(
                                    icon: const Icon(Icons.person, size: 40),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Routes.register);
                                    },
                                    label: Text(
                                      StringManager.signUp,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    )),
                              ),
                              const SizedBox(height: 100),
                            ],
                          ),
                        ))
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
