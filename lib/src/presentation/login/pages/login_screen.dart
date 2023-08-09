import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doft/src/presentation/login/cubit/login_cubit.dart';

import '../../../config/routes/routes.dart';
import '../../../core/utils/image_manager.dart';

import '../widgets/myform.dart';

import '../../../injector.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginCubit = instance<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) {
        return loginCubit;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (ctx, state) {
                if (state is LoginError) {
                  showDialog(
                      context: ctx,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: Text(state.errorMessage),
                        );
                      });
                } else if (state is LoginComplete) {
                  Navigator.pushReplacementNamed(context, Routes.home);
                }
              },
              builder: (ctx, state) {
                if (state is LoginLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  var loginCubit = BlocProvider.of<LoginCubit>(ctx);
                  return Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Image.asset(ImageManager.logo),
                      ),
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          child: MyForm(
                            emailController: loginCubit.emailController,
                            passwordController: loginCubit.passwordContriller,
                            isEmailError: loginCubit.isEmailEmpty,
                            isPasswordError: loginCubit.isPasswordEmpty,
                            loginPressed: () => loginCubit.signIn(),
                            registerPressed: () {
                              Navigator.pushNamed(context, Routes.register);
                            },
                          ),
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
