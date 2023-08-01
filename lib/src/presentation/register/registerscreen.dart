import 'package:doft/src/core/date_picker.dart';
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
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {},
          builder: (context, state) {
            var mycubit = BlocProvider.of<RegisterCubit>(context);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // profile photo
                Container(
                  child: SvgPicture.asset(
                    'assets/images/profile-circle.svg',
                    color: Colors.white,
                    height: 200,
                  ),
                ),
                MyTextField(
                    labelText: 'username',
                    errorMessage: 'username is required',
                    keyboardType: TextInputType.name,
                    icon: null,
                    controller: mycubit.usernameController,
                    hintText: 'Enter your username',
                    isError: true),
                IconButton(
                    onPressed: () async {
                      mycubit.birth = await pickDate(context);
                    },
                    icon: const Icon(size: 30, Icons.calendar_month)),

                Container(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Register'))),
              ],
            );
          },
        ),
      ),
    );
  }
}
