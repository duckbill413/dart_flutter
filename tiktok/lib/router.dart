import 'package:go_router/go_router.dart';
import 'package:tiktok/features/authentication/email_screen.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/sign_up_screen.dart';
import 'package:tiktok/features/authentication/username_screen.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: SignUpScreen.routeName,
    builder: (context, state) => SignUpScreen(),
  ),
  GoRoute(
    path: LoginScreen.routeName,
    builder: (context, state) => LoginScreen(),
  ),
  GoRoute(
    path: UsernameScreen.routeName,
    builder: (context, state) => UsernameScreen(),
  ),
  GoRoute(
    path: EmailScreen.routeName,
    builder: (context, state) => EmailScreen(),
  ),
]);
