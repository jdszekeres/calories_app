import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './pages/sign_up.dart';
import './pages/sign_in.dart';

import './pages/home_page.dart';
import './pages/goals_page.dart';
import './pages/list_page.dart';
import './pages/add_page.dart';
import './pages/settings_page.dart';
import './auth.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './firebase_options.dart';
import 'pages/convert_anon.dart';
import 'pages/sign_in_anon.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
  }

  runApp(const CaloriesTrackerApp());
}

class AuthNotifier extends ChangeNotifier {
  AuthNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      notifyListeners();
    });
  }
}

final AuthNotifier _authNotifier = AuthNotifier();

final GoRouter _router = GoRouter(
  refreshListenable: _authNotifier,
  routes: <RouteBase>[
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return SignUpPage();
      },
    ),
    GoRoute(
      path: '/signin',
      builder: (BuildContext context, GoRouterState state) {
        return SignInPage();
      },
    ),
    GoRoute(
      path: '/sign_in_anonymous',
      builder: (BuildContext context, GoRouterState state) {
        return SignInAnon();
      },
    ),
    GoRoute(
      path: '/convert_anonymous_to_email',
      builder: (BuildContext context, GoRouterState state) {
        return ConvertAnon();
      },
      redirect: (context, state) =>
          !Auth().isLoggedIn ? '/sign_in_anonymous' : null,
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
      redirect: (context, state) {
        if (!Auth().isLoggedIn) {
          return '/signin';
        }
        return null;
      },
    ),
    GoRoute(
      path: '/goals',
      builder: (context, state) {
        return GoalsPage();
      },
      redirect: (context, state) {
        if (!Auth().isLoggedIn) {
          return '/signin';
        }
        return null;
      },
    ),
    GoRoute(
      path: '/list',
      builder: (context, state) {
        return const ListPage();
      },
      redirect: (context, state) {
        if (!Auth().isLoggedIn) {
          return '/signin';
        }
        return null;
      },
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) {
        return const AddPage();
      },
      redirect: (context, state) {
        if (!Auth().isLoggedIn) {
          return '/signin';
        }
        return null;
      },
    ),

    GoRoute(
      path: '/settings',
      builder: (context, state) {
        return SettingsPage();
      },
      redirect: (context, state) {
        if (!Auth().isLoggedIn) {
          return '/signin';
        }
        return null;
      },
    ),
  ],
);

class CaloriesTrackerApp extends StatelessWidget {
  const CaloriesTrackerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Calorie Tracker',
      routerConfig: _router,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
    );
  }
}
