import 'package:doft/src/data/data_source/remote_data_source/firebase_auth.dart';
import 'package:doft/src/domain/repositories/repositories.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doft/src/data/repository/repository_impl.dart';
import 'package:doft/src/presentation/login/cubit/login_cubit.dart';
import 'package:doft/src/presentation/shared/text_field.dart';

import '../../../config/routes/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) {
        return LoginCubit(RepositoryImpl(auth: FirebaseAuthentication()));
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromARGB(255, 54, 53, 53),
                  Color.fromARGB(255, 183, 179, 179),
                ]),
          ),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (ctx, state) {
              if (state is LoginError) {
                showDialog(
                    context: ctx,
                    builder: (ctx) {
                      return const AlertDialog(
                        title: Text('Error'),
                      );
                    });
              } else if (state is LoginComplete) {
                Navigator.pushReplacementNamed(context, Routes.home);
              }
            },
            builder: (ctx, state) {
              return state is LoginLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            color: Colors.blue,
                            height: 200,
                            width: 200,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          
                          child: MyForm(
                              emailController: BlocProvider.of<LoginCubit>(ctx).emailController,
                              passwordController:  BlocProvider.of<LoginCubit>(ctx).passwordContriller,
                              isEmailError: false,
                              isPasswordError: false),
                        ),
                        Expanded(
                            flex: 2,
                            child: MyButton(
                                loginPressed: () {
                                  BlocProvider.of<LoginCubit>(ctx).signIn();
                                },
                                registerPressed: () {})),
                        const SizedBox(height: 20),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key, required this.loginPressed, required this.registerPressed});

  final VoidCallback loginPressed;
  final VoidCallback registerPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: loginPressed,
          child: const Text('Login'),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don\'t have an account ? '),
            TextButton(
                onPressed: registerPressed, child: const Text('Register'))
          ],
        )
      ],
    );
  }
}

class MyForm extends StatelessWidget {
  const MyForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isEmailError,
    required this.isPasswordError,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isEmailError;
  final bool isPasswordError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
            labelText: 'email',
            errorMessage: 'email required',
            keyboardType: TextInputType.emailAddress,
            icon: Icons.email_outlined,
            controller: emailController,
            hintText: 'dakhel nayek',
            isError: isEmailError),
        const SizedBox(height: 20),
        MyTextField(
            isPassword: true,
            labelText: 'password',
            errorMessage: 'password is required',
            keyboardType: TextInputType.emailAddress,
            icon: Icons.email_outlined,
            controller: passwordController,
            hintText: 'dakhel nayek',
            isError: isPasswordError),
      ],
    );
  }
}
