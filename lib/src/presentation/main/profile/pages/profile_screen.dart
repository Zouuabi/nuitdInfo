import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/data/models/user.dart';
import 'package:mouvema/src/presentation/main/profile/cubit/profile_cubit.dart';
import 'package:mouvema/src/presentation/main/profile/cubit/profile_state.dart';
import '../../../../config/routes/routes.dart';
import '../../../../injector.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final cubit = instance<ProfileCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => cubit,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              maxRadius: 100,
              minRadius: 80,
              backgroundImage: NetworkImage(user.image),
            ),
            Text(
              user.username,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              user.email,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(height: 50),

            /// Features
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, Routes.fillProfil);
              },
              leading: const Icon(Icons.person),
              title: const Text('Edit Profile'),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              ),
            ),
            const ListTile(
              leading: Icon(Icons.car_repair),
              title: Text('Edit Car Profile'),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              ),
            ),
            const ListTile(
              leading: Icon(Icons.language),
              title: Text('Edit Language'),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              ),
            ),
            const ListTile(
              leading: Icon(Icons.light_mode),
              title: Text('Theme'),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              ),
            ),

            TextButton.icon(
                onPressed: onLogoutPressed,
                icon: const Icon(Icons.logout_outlined),
                label: const Text('Logout'))
          ],
        ),
      ),
    ),
  );
}
