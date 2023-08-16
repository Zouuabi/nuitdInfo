import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doft/src/config/routes/routes.dart';
import 'package:doft/src/presentation/main/profile/profile_screen_cubit.dart';

import '../../../injector.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileScreenCubit>(
      create: (context) => instance<ProfileScreenCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fill Your Profil'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<ProfileScreenCubit, ProfileScreenState>(
            listener: (context, state) {
              // if (state.status == Status.success) {
              //   showDialog(
              //       context: context,
              //       builder: (context) {
              //         return AlertDialog(
              //           title: const Text('Profile updated successfully!'),
              //           actions: [
              //             TextButton(
              //                 onPressed: () {
              //                   Navigator.pushReplacementNamed(
              //                       context, Routes.main);
              //                 },
              //                 child: const Text('Go To main'))
              //           ],
              //         );
              //       });
              // } else if (state is ProfilError) {
              //   showDialog(
              //       context: context,
              //       builder: (context) {
              //         return AlertDialog(
              //           title: Text(state.errorMessage),
              //           actions: [
              //             TextButton(
              //                 onPressed: () {
              //                   Navigator.pop(context);
              //                 },
              //                 child: const Text('Cancel'))
              //           ],
              //         );
              //       });
              // } else
              if (state.status == Status.loading) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
              }
              if (state.status == Status.success) {
                Navigator.pushReplacementNamed(context, Routes.login);
              }
            },
            builder: (context, state) {
              return Center(
                  child: FilledButton(
                onPressed: () {
                  BlocProvider.of<ProfileScreenCubit>(context).logout();
                },
                child: const Text('Logout'),
              ));
            },
          ),
        ),
      ),
    );
  }
}
