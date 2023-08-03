import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doft/src/core/date_picker.dart';
import 'package:doft/src/presentation/register/cubit/register_cubit.dart';
import 'package:doft/src/presentation/shared/text_field.dart';

import '../../shared/date.dart';
import '../widgets/profile_photo.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {},
            builder: (context, state) {
              var mycubit = BlocProvider.of<RegisterCubit>(context);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // profile photo
                  Expanded(
                      flex: 2,
                      child: ProfilePhotoSelector(
                          pictureFile: mycubit.photo,
                          onPressed: () {
                            mycubit.addPhoto();
                          })),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: _getForm(mycubit, state, context),
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

  Column _getForm(RegisterCubit mycubit, RegisterState state, BuildContext context) {
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
                          isError: state is RegisterError &&
                                  state.errorMessage == 'username empty'
                              ? true
                              : false,
                        ),
                        const SizedBox(height: 20),
                        DateWidget(
                          isError: state is RegisterError &&
                                  state.errorMessage == 'date empty'
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
                    );
  }
}
