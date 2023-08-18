import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/repository_impl.dart';
import '../../../injector.dart';
import '../../shared/date.dart';
import '../../shared/show_date_picker.dart';
import '../../shared/text_field.dart';
import '../cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(instance<RepositoryImpl>()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: const Text('Register'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSubmited) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Registration Complete'),
                        actions: [
                          TextButton(
                              onPressed: () {}, child: const Text('Sign In'))
                        ],
                      );
                    });
              } else if (state is RegisterError) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(state.errorMessage),
                        actions: [
                          TextButton(
                              onPressed: () {}, child: const Text('Sign In'))
                        ],
                      );
                    });
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    'Create your \nAccount',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.displayMedium,
                  )),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // email field
                          const MyTextField(
                              labelText: 'Email',
                              errorMessage: 'Email is required',
                              keyboardType: TextInputType.emailAddress,
                              icon: Icons.email_outlined,
                              controller: null,
                              hintText: 'user@example.com',
                              isError: false),
                          const SizedBox(
                            height: 30,
                          ),
                          // password field
                          const MyTextField(
                              isPassword: true,
                              labelText: 'Password',
                              errorMessage: 'Password is required',
                              keyboardType: TextInputType.emailAddress,
                              icon: Icons.lock_open_sharp,
                              controller: null,
                              hintText: 'Enter your password',
                              isError: false),
                          const SizedBox(height: 30),
                          // remember me button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Remember me',
                                style: Theme.of(context).textTheme.labelMedium,
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 70,
                            child: FilledButton(
                                onPressed: () {}, child: const Text('Sign up')),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                              child: Text(
                            'or continue with',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                          const SizedBox(height: 30),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.facebook,
                                size: 60,
                              ),
                              Icon(
                                Icons.g_mobiledata,
                                size: 60,
                              ),
                              Icon(
                                Icons.apple,
                                size: 60,
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account ? ',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Log in')),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Column _getForm(
      RegisterCubit mycubit, RegisterState state, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyTextField(
          labelText: 'username',
          errorMessage: 'username is required',
          keyboardType: TextInputType.name,
          icon: null,
          controller: mycubit.usernameController,
          hintText: 'Enter your username',
          isError:
              state is RegisterError && state.errorMessage == 'username empty'
                  ? true
                  : false,
        ),
        const SizedBox(height: 20),
        DateWidget(
          isError: state is RegisterError && state.errorMessage == 'date empty'
              ? true
              : false,
          label: state is RegisterDateAdded
              ? state.date.substring(0, 9)
              : mycubit.birth,
          onPressed: () {
            pickDate(context).then((date) {
              mycubit.dateAdded(date.toString());
            });
          },
        ),
        const SizedBox(height: 20),
        MyTextField(
          labelText: 'email',
          errorMessage: 'email is required',
          keyboardType: TextInputType.name,
          icon: null,
          controller: mycubit.emailController,
          hintText: 'user@example.com',
          isError: state is RegisterError && state.errorMessage == 'email empty'
              ? true
              : false,
        ),
        const SizedBox(height: 20),
        MyTextField(
          isPassword: true,
          labelText: 'password',
          errorMessage: 'password is required',
          keyboardType: TextInputType.name,
          icon: null,
          controller: mycubit.passwordController,
          hintText: 'Enter your password',
          isError: ((state is RegisterError) &&
                  state.errorMessage == 'password empty')
              ? true
              : false,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              mycubit.register();
            },
            child: const Text('Register')),
      ],
    );
  }
}
