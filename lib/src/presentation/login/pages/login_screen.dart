import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/routes.dart';

import '../../../core/utils/color_manager.dart';
import '../../../core/utils/image_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../injector.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return instance<LoginScreenCubit>();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: BlocConsumer<LoginScreenCubit, LoginScreenState>(
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
                      Spacer(),
                      Flexible(
                          flex: 3,
                          child: Image.asset(
                            ImageManager.logo,
                          )),
                      Spacer(),
                      Flexible(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
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
                                onPressed: () {
                                  instance<LoginScreenCubit>()
                                      .continueWithGoogle();
                                },
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
                                  color: ColorManager.mouvemaTeal,
                                ),
                                const Text('Or'),
                                Container(
                                  height: 1,
                                  width: 100,
                                  color: ColorManager.mouvemaTeal,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 70,
                              child: FilledButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.loginWithPassword);
                                  },
                                  child: const Text(
                                    'Sign in with password',
                                  )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account ? ',
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
