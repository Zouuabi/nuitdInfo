import 'package:doft/src/core/date_picker.dart';
import 'package:doft/src/presentation/register/cubit/register_cubit.dart';
import 'package:doft/src/presentation/shared/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/image_picker.dart';
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
                          onPressed: () async {
                            var a = await takepicture();
                            if (a != null) {
                              mycubit.photoAdded(a);
                            }
                          })),
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
                            controller: BlocProvider.of<RegisterCubit>(context)
                                .usernameController,
                            hintText: 'Enter your username',
                            isError: false,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: MyTextField(
                                    labelText: state is RegisterDateAdded
                                        ? state.date
                                        : 'YYYY-MM-DD',
                                    errorMessage: 'Pick a date',
                                    keyboardType: TextInputType.text,
                                    icon: null,
                                    controller: null,
                                    hintText: 'sdfd',
                                    isError: false,
                                    isEnabled: false),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    pickDate(context).then((date) {
                                      mycubit.dateAdded(
                                          date.toString().substring(0, 9));
                                    });
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
                              controller: mycubit.usernameController,
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
