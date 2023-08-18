import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mouvema/src/data/models/user.dart';
import 'package:mouvema/src/presentation/main/profile/cubit/profile_cubit.dart';
import 'package:mouvema/src/presentation/main/profile/cubit/profile_state.dart';
import '../../../../config/routes/routes.dart';
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
              } else if (state.status == Status.logOut) {
                Navigator.pushReplacementNamed(context, Routes.login);
              }
            },
            builder: (context, state) {
              return state.status == Status.loading
                  ? const Center(child: CircularProgressIndicator())
                  : _getProfile(
                      user: state.data!,
                      context: context,
                      onLogoutPressed: () {
                        BlocProvider.of<ProfileCubit>(context).logOut();
                      });
            },
          ),
        ),
      ),
    );
  }
}

Widget _getProfile(
    {required MyUser user,
    required BuildContext context,
    required VoidCallback onLogoutPressed}) {
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
              onPressed: onLogoutPressed, child: const Text('Log Out')),
        ],
      ),
    ),
  );
}
