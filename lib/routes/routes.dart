import 'package:flutter_todo/features/authentication/presentation/screens/register_screen.dart';
import 'package:flutter_todo/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:flutter_todo/features/task_management/presentation/screens/main_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

enum AppRoutes {
  main,
  signIn,
  register,
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(initialLocation: '/main', debugLogDiagnostics: true, routes: [
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
