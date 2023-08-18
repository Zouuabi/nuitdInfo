import 'package:flutter/material.dart';

import '../../shared/text_field.dart';

class FillProfileScreen extends StatelessWidget {
  const FillProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO : hedhi hya lii lezm teklm
    return Scaffold(
      appBar: AppBar(),
    );
  }

  //  Column _getForm(
  //     ProfilCubit mycubit, ProfilState state, BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       ProfilePhotoSelector(
  //           pictureFile: mycubit.photo,
  //           onPressed: () {
  //             mycubit.addPhoto();
  //           }),
  //       MyTextField(
  //         labelText: 'username',
  //         errorMessage: 'username is required',
  //         keyboardType: TextInputType.name,
  //         icon: Icons.person,
  //         controller: mycubit.usernameController,
  //         hintText: 'Enter your username',
  //         isError:
  //             state is ProfilError && state.errorMessage == 'username empty'
  //                 ? true
  //                 : false,
  //       ),
  //       const SizedBox(height: 20),
  //       DateWidget(
  //         isError: kFlutterMemoryAllocationsEnabled,
  //         label: state is ProfilDateAdded
  //             ? state.date.substring(0, 9)
  //             : mycubit.birth,
  //         onPressed: () {
  //           pickDate(context).then((date) {
  //             mycubit.dateAdded(date.toString());
  //           });
  //         },
  //       ),
  //       const SizedBox(height: 20),
  //       MyTextField(
  //         labelText: 'Tel',
  //         errorMessage: 'Enter your Tel',
  //         keyboardType: TextInputType.phone,
  //         icon: Icons.phone,
  //         controller: mycubit.telController,
  //         hintText: 'phone number',
  //         isError: state is ProfilError && state.errorMessage == 'email empty'
  //             ? true
  //             : false,
  //       ),
  //       const SizedBox(height: 20),
  //       ElevatedButton(
  //           onPressed: () {
  //             mycubit.fillProfile();
  //           },
  //           child: const Text('Register')),
  //     ],
  //   );
  // }
}
