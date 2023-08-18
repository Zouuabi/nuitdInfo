import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mouvema/src/data/models/user.dart';
import 'package:mouvema/src/presentation/main/profile/cubit/profile_cubit.dart';
import 'package:mouvema/src/presentation/main/profile/cubit/profile_state.dart';
import '../../../../core/utils/image_manager.dart';
import '../../../../injector.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => instance<ProfileCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state.status == Status.failed) {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                        title: Text(state.errorMessage!),
                        actions: [
                          Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('OK')),
                          )
                        ]);
                  },
                );
              }
            },
            builder: (context, state) {
              if (state.status == Status.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == Status.success) {
                return _getProfile(BlocProvider.of<ProfileCubit>(context),
                    context, state.data!);
              } else {
                return const Center(child: Text('Initial State'));
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget _getProfile(ProfileCubit mycubit, BuildContext context, MyUser user) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: ClipOval(
                    child: (user.image == '')
                        ? SvgPicture.asset(
                            ImageManager.profile,
                            // ignore: deprecated_member_use
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            user.image,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),

                // ClipOval(
                //   child: (user.image == '')
                //       ? SvgPicture.asset(
                //           ImageManager.profile,
                //           // ignore: deprecated_member_use
                //           height: 200,
                //           width: 200,
                //           fit: BoxFit.cover,
                //         )
                //       : Image.network(user.image),
                // ),
              ])
            ],
          ),
          Center(child: Text(user.username)),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(user.email),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.phone),
            title: Text(user.tel),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: Text(user.birdhdate),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                mycubit.logOut();
              },
              child: const Text('Log Out')),
        ],
      ),
    ),
  );
}
