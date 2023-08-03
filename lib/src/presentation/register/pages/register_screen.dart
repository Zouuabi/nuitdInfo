import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doft/src/core/date_picker.dart';
import 'package:doft/src/data/data_source/remote_data_source/firebase_auth.dart';
import 'package:doft/src/data/repository/repository_impl.dart';
import 'package:doft/src/presentation/register/cubit/register_cubit.dart';
import 'package:doft/src/presentation/shared/text_field.dart';

import '../../shared/date.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) =>
          RegisterCubit(RepositoryImpl(auth: FirebaseAuthentication())),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          centerTitle: true,
        ),
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterError &&
                state.errorMessage == 'email not verified') {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Verify email'),
                      actions: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Confirm Verification'),
                        )
                      ],
                    );
                  });
            }
          },
          builder: (context, state) {
            var mycubit = BlocProvider.of<RegisterCubit>(context);

            return Container(
              height: double.infinity,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextField(
                    labelText: 'email',
                    errorMessage: 'email is required',
                    keyboardType: TextInputType.name,
                    icon: null,
                    controller: mycubit.emailController,
                    hintText: 'user@example.com',
                    isError: state is RegisterError &&
                            state.errorMessage == 'email empty'
                        ? true
                        : false,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
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
              ),
            );
          },
        ),
      ),
    );
  }

  // Expanded(
  //                     flex: 2,
  //                     child: ProfilePhotoSelector(
  //                         pictureFile: mycubit.photo,
  //                         onPressed: () {
  //                           mycubit.addPhoto();
  //                         })),

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
              : 'YYYY-MM-DD',
          onPressed: () {
            pickDate(context).then((date) {
              mycubit.dateAdded(date.toString());
            });
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
