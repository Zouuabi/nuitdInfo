import 'package:doft/src/presentation/shared/text_field.dart';
import 'package:flutter/material.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [

          MyTextField(labelText: 'email', errorMessage: 'email required', keyboardType: TextInputType.emailAddress, icon: , controller: controller, hintText: hintText, isError: isError)
        ]),
      ),

    );
  }
}