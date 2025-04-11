import 'package:go_router/go_router.dart';
import 'package:tiktok/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/sign_up_screen.dart';
import 'package:tiktok/features/onboarding/interests_screen.dart';

final router = GoRouter(routes: [
  GoRoute(
    name: SignUpScreen.routeName,
    path: SignUpScreen.routeURL,
    builder: (context, state) => SignUpScreen(),
  ),
  GoRoute(
    name: LoginScreen.routeName,
    path: LoginScreen.routeURL,
    builder: (context, state) => LoginScreen(),
  ),
  GoRoute(
    name: InterestsScreen.routeName,
    path: InterestsScreen.routeURL,
    builder: (context, state) => InterestsScreen(),
  ),
  GoRoute(
    name: MainNavigationScreen.routeName,
    path: "/:tab(home|discover|inbox|profile)",
    builder: (context, state) => MainNavigationScreen(
      tab: state.params["tab"]!,
    ),
  )
]);
