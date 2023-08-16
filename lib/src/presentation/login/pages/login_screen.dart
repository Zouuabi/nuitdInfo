import 'package:doft/src/core/utils/colors_manager.dart';
import 'package:doft/src/data/repository/repository_impl.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doft/src/presentation/login/cubit/login_cubit.dart';

import '../../../config/routes/routes.dart';
import '../../../core/utils/image_manager.dart';

import '../../../injector.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) {
        return LoginCubit(instance<RepositoryImpl>());
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: BlocConsumer<LoginCubit, LoginScreenState>(
              listener: (ctx, state) {
                if (state.status == Status.failed) {
                  showDialog(
                      context: ctx,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: Text(state.errorMessage!),
                        );
                      });
                } else if (state.status == Status.success) {
                  Navigator.pushReplacementNamed(context, Routes.main);
                }
              },
              builder: (ctx, state) {
                if (state.status == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    children: [
                      Flexible(
                          flex: 2,
                          child:
                              ClipOval(child: Image.asset(ImageManager.logo))),
                      Flexible(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Ahla b nahla ',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            OutlinedButton.icon(
                                icon: const Icon(
                                  Icons.facebook,
                                  size: 50,
                                ),
                                onPressed: () {},
                                label: Text(
                                  'Continue With Facebook',
                                  style: Theme.of(context).textTheme.labelLarge,
                                )),
                            OutlinedButton.icon(
                                icon: const Icon(
                                  Icons.g_mobiledata,
                                  size: 50,
                                ),
                                onPressed: () {},
                                label: Text(
                                  'Continue With Google  ',
                                  style: Theme.of(context).textTheme.labelLarge,
                                )),
                            OutlinedButton.icon(
                                icon: const Icon(
                                  Icons.apple,
                                  size: 50,
                                ),
                                onPressed: () {},
                                label: Text(
                                  'Continue With Apple  ',
                                  style: Theme.of(context).textTheme.labelLarge,
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 1,
                                  width: 100,
                                  color: ColorManager.mouvemaPink400,
                                ),
                                const Text('Or'),
                                Container(
                                  height: 1,
                                  width: 100,
                                  color: ColorManager.mouvemaPink400,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 70,
                              child: FilledButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Sign in with password',
                                  )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\t have an account ? ',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Routes.register);
                                    },
                                    child: const Text('Sign up')),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
