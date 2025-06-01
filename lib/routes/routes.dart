import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_todo/features/authentication/presentation/screens/register_screen.dart';
import 'package:flutter_todo/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:flutter_todo/features/task_management/presentation/screens/main_screen.dart';
import 'package:flutter_todo/routes/go_router_refresh_stream.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

enum AppRoutes {
  main,
  signIn,
  register,
}

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return GoRouter(
      initialLocation: '/main',
      debugLogDiagnostics: true,
      redirect: (ctx, state) {
        final user = firebaseAuth.currentUser;
        final isAuthenticated = user != null;

        if (isAuthenticated &&
            (state.uri.toString() == '/signIn' ||
                state.uri.toString() == '/register')) {
          return '/main'; // Redirect to main if already signed in
        } else if (!isAuthenticated && state.uri.toString() == '/main') {
          return '/signIn'; // Redirect to sign in if not authenticated
        }
        return null; // No redirection needed
      },
      refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),
      routes: [
        GoRoute(
          path: "/main",
          name: AppRoutes.main.name,
          builder: (context, state) => const MainScreen(),
        ),
        GoRoute(
          path: "/signIn",
          name: AppRoutes.signIn.name,
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: "/register",
          name: AppRoutes.register.name,
          builder: (context, state) => const RegisterScreen(),
        ),
      ]);
}
