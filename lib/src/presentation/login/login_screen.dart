import 'package:mouvema/src/presentation/shared/text_field.dart';
import 'package:flutter/material.dart';

import '../../data/data_source/remote_data_source/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 54, 53, 53),
                Color.fromARGB(255, 183, 179, 179),
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
                width: 200,
              ),
              MyTextField(
                  labelText: 'email',
                  errorMessage: 'email required',
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email_outlined,
                  controller: TextEditingController(),
                  hintText: 'dakhel nayek',
                  isError: false),
              const SizedBox(height: 20),
              MyTextField(
                  isPassword: true,
                  labelText: 'password',
                  errorMessage: 'password is required',
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email_outlined,
                  controller: TextEditingController(),
                  hintText: 'dakhel nayek',
                  isError: false),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('me andekch ? '),
                  TextButton(
                      onPressed: () async {
                        var a = FirebaseAuthentication();
                        await a.signIn(email: 'dqsdqs', password: 'qsdqdqsdq');
                      },
                      child: const Text('Register'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
