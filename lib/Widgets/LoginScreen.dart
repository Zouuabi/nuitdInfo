import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void verifyUser(response) async {
    final url = Uri.https(
        'doft-11db5-default-rtdb.europe-west1.firebasedatabase.app',
        'Users.json');
    final response = await http.get(url);
  }

  void Login() {
    var response;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      verifyUser(response);
      if (response.statusCode >= 404) {
        print('404');
        return;
      } else if (response.statusCode == 200) {
        if (response.body == 'null') {}
      }
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(106, 130, 129, 129), Colors.black54])),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white70, fontSize: 30),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    onSaved: (newValue) {
                      _email = newValue!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Email';
                      }
                    },
                    decoration: const InputDecoration(
                        hintText: 'Email', icon: Icon(Icons.mail)),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    obscureText: true,
                    onSaved: (newValue) {
                      _password = newValue!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Password';
                      }
                    },
                    decoration: const InputDecoration(
                        hintText: 'Password', icon: Icon(Icons.key)),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 50),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        Login();
                      },
                      child: const Text('LOG IN')),
                  const SizedBox(height: 30),
                  Text('or log in with',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white70)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.facebook),
                        iconSize: 40,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.email),
                          iconSize: 40),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.apple),
                          iconSize: 40)
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () {}, child: const Text('Forget Password?')),
                  const SizedBox(
                    height: 130,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('Dont have an account?'),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ))
                  ]),
                ],
              )),
        ),
      ),
    );
  }
}
