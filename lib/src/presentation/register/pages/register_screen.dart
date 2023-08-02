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
              // var mycubit = ;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // profile photo
                  const Expanded(flex: 2, child: ProfilePhotoSelector()),
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
                              controller:
                                  BlocProvider.of<RegisterCubit>(context)
                                      .usernameController,
                              hintText: 'Enter your username',
                              isError: false),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: MyTextField(
                                    labelText: context
                                        .watch<RegisterCubit>()
                                        .getBirthDate,
                                    errorMessage: 'Pick a date',
                                    keyboardType: TextInputType.text,
                                    icon: null,
                                    controller: null,
                                    hintText:
                                        BlocProvider.of<RegisterCubit>(context)
                                            .getBirthDate,
                                    isError: false,
                                    isEnabled: true),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    BlocProvider.of<RegisterCubit>(context)
                                        .birth = await pickDate(context);
                                  },
                                  icon: const Icon(
                                      size: 30, Icons.calendar_month))
                            ],
                          ),
                          const SizedBox(height: 20),
                          MyTextField(
                              labelText: 'email',
                              errorMessage: 'email is required',
                              keyboardType: TextInputType.name,
                              icon: null,
                              controller:
                                  BlocProvider.of<RegisterCubit>(context)
                                      .usernameController,
                              hintText: 'user@example.com',
                              isError: false),
                          const SizedBox(height: 20),
                          MyTextField(
                              labelText: 'password',
                              errorMessage: 'password is required',
                              keyboardType: TextInputType.name,
                              icon: null,
                              controller:
                                  BlocProvider.of<RegisterCubit>(context)
                                      .usernameController,
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


