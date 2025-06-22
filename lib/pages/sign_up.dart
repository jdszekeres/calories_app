import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../auth.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          ElevatedButton(
            onPressed: () {
              Auth()
                  .signUpWithEmailAndPassword(
                    emailController.text,
                    usernameController.text,
                    passwordController.text,
                  )
                  .then((_) {
                    if (context.mounted) context.go('/');
                  });
            },
            child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/signin');
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
