import 'package:doft/src/core/date_picker.dart';
import 'package:doft/src/core/utils/image_manager.dart';
import 'package:doft/src/presentation/register/cubit/register_cubit.dart';
import 'package:doft/src/presentation/shared/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';

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
                  Expanded(flex: 2, child: ProfilePhotoSelector()),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyTextField(
                              labelText: 'username',
                              errorMessage: 'username is required',
                              keyboardType: TextInputType.name,
                              icon: null,
                              controller: mycubit.usernameController,
                              hintText: 'Enter your username',
                              isError: false),
                          const SizedBox(height: 20),
                          MyTextField(
                              labelText: 'email',
                              errorMessage: 'email is required',
                              keyboardType: TextInputType.name,
                              icon: null,
                              controller: mycubit.usernameController,
                              hintText: 'user@example.com',
                              isError: false),
                          const SizedBox(height: 20),
                          MyTextField(
                              labelText: 'password',
                              errorMessage: 'password is required',
                              keyboardType: TextInputType.name,
                              icon: null,
                              controller: mycubit.usernameController,
                              hintText: 'Enter your password',
                              isError: false),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () {}, child: const Text('Register')),
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
}


