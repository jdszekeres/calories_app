import 'package:calories_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/foundation.dart';
import '../auth.dart';

// Conditional import for web launcher
import '../web_launcher_stub.dart'
    if (dart.library.html) '../web_launcher_web.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      // appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    local.welcomeBack,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: local.email,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: local.password,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await Auth().signInWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                        );
                        if (context.mounted) {
                          context.go('/');
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(Auth.prettyPrintError(e))),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      local.signIn,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      context.go('/signup');
                    },
                    child: Text(local.noAccount),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/sign_in_anonymous');
                    },
                    child: Text(local.tryAnon),
                  ),
                  TextButton(
                    onPressed: () {
                      const url =
                          "https://apps.apple.com/us/app/calorie-tracker-pro-max/id6749119246";
                      if (kIsWeb) {
                        // ignore: undefined_prefixed_name
                        launchUrlString(url);
                      } else {
                        launchUrlString(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    child: Text(local.downloadApp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
