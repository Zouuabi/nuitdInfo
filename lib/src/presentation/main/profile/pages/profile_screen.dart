import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/core/utils/string_manager.dart';
import 'package:mouvema/src/data/models/user.dart';
import 'package:mouvema/src/data/repository/repository_impl.dart';
import 'package:mouvema/src/presentation/main/profile/cubit/profile_cubit.dart';
import 'package:mouvema/src/presentation/main/profile/cubit/profile_state.dart';
import '../../../../config/routes/routes.dart';
import '../../../../injector.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  // final cubit = ProfileCubit(instance<RepositoryImpl>());
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(instance<RepositoryImpl>()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state.status == Status.failed) {
                  AwesomeDialog(
                    btnOkColor: Colors.teal,
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.topSlide,
                    title: StringManager.error,
                  ).show();
                } else if (state.status == Status.logOut) {
                  Navigator.pushReplacementNamed(context, Routes.login);
                }
              },
              builder: (context, state) {
                if (state.status == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == Status.success) {
                  return _getProfile(
                      user: state.data!,
                      context: context,
                      onLogoutPressed: () {
                        BlocProvider.of<ProfileCubit>(context).logOut();
                      });
                } else {
                  return Center(
                      child:
                          Text(state.errorMessage ?? 'Something went wrong'));
                }
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
              title: Text(StringManager.editProfile),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.car_repair),
              title: Text(StringManager.editCarProfile),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(StringManager.editLanguage),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              ),
            ),
            ListTile(
                leading: const Icon(Icons.light_mode),
                title: Text(StringManager.darkTheme)),
            // trailing:

            TextButton.icon(
                onPressed: onLogoutPressed,
                icon: const Icon(Icons.logout_outlined),
                label: Text(StringManager.singOut))
          ],
        ),
      ),
    ),
  );
}
