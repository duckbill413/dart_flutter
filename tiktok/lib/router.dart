import 'package:go_router/go_router.dart';
import 'package:tiktok/features/authentication/email_screen.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/sign_up_screen.dart';
import 'package:tiktok/features/authentication/username_screen.dart';
import 'package:tiktok/features/users/user_profile_screen.dart';

final router = GoRouter(routes: [
  GoRoute(
    name: SignUpScreen.routeName,
    path: SignUpScreen.routeURL,
    builder: (context, state) => SignUpScreen(),
    routes: [
      GoRoute(
        name: UsernameScreen.routeName,
        path: UsernameScreen.routeURL,
        builder: (context, state) => UsernameScreen(),
        routes: [
          GoRoute(
            name: EmailScreen.routeName,
            path: EmailScreen.routeURL,
            builder: (context, state) {
              var args = state.extra as EmailScreenArgs;
              return EmailScreen(
                username: args.username,
              );
            },
          ),
        ],
      ),
    ],
  ),
  GoRoute(
    name: LoginScreen.routeName,
    path: LoginScreen.routeURL,
    builder: (context, state) => LoginScreen(),
  ),
  // GoRoute(
  //   name: "username_screen",
  //   path: UsernameScreen.routeName,
  //   pageBuilder: (context, state) => CustomTransitionPage(
  //     child: UsernameScreen(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) =>
  //         FadeTransition(
  //       opacity: animation,
  //       child: ScaleTransition(
  //         scale: animation,
  //         child: child,
  //       ),
  //     ),
  //   ),
  // ),

  GoRoute(
    path: "/users/:username",
    builder: (context, state) {
      final username = state.params['username'];
      final tab = state.queryParams['show'];

      return UserProfileScreen(
        username: username!,
        tab: tab!,
      );
    },
  ),
]);
