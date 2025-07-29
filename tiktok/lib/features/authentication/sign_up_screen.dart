import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/common/theme_config/view_models/theme_config_vm.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/username_screen.dart';
import 'package:tiktok/features/authentication/view_models/social_auth_vm.dart';
import 'package:tiktok/features/authentication/widgets/auth_button.dart';
import 'package:tiktok/generated/l10n.dart';

class SignUpScreen extends ConsumerWidget {
  static String routeURL = "/";
  static const routeName = "signUp";

  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) async {
    context.pushNamed(LoginScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(
          seconds: 1,
        ),
        reverseTransitionDuration: Duration(
          seconds: 1,
        ),
        pageBuilder: (context, animation, secondaryAnimation) =>
            UsernameScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: Offset(0, -1),
            end: Offset.zero,
          ).animate(animation);
          final opacityAnimation = Tween<double>(
            begin: 0.5,
            end: 1.0,
          ).animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: opacityAnimation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var localeOf = Localizations.localeOf(context);
    return OrientationBuilder(builder: (context, orientation) {
      // if (orientation == Orientation.landscape) {
      //   return Scaffold(
      //     body: Center(
      //       child: Text("Plz rotate ur phone!"),
      //     ),
      //   );
      // }
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size40,
            ),
            child: Column(
              children: [
                Gaps.v80,
                Text(
                  // S.of(context).signUpTitle("Tiktok", DateTime.now()),
                  "틱톡 회원가입",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Gaps.v20,
                Opacity(
                  opacity: 0.7,
                  child: Text(
                    S.of(context).signUpSubTitle(12), // pluralization
                    style: TextStyle(
                      fontSize: Sizes.size14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Gaps.v40,
                if (orientation == Orientation.portrait) ...[
                  GestureDetector(
                    onTap: () => _onEmailTap(context),
                    child: AuthButton(
                      icon: FaIcon(FontAwesomeIcons.user),
                      text: S.of(context).emailPasswordBtn,
                    ),
                  ),
                  Gaps.v16,
                  GestureDetector(
                    onTap: () => ref
                        .read(socialAuthProvider.notifier)
                        .githubSignIn(context),
                    child: AuthButton(
                      icon: FaIcon(FontAwesomeIcons.github),
                      text: S.of(context).githubSignUpBtn,
                    ),
                  ),
                ],
                if (orientation == Orientation.landscape)
                  Row(
                    children: [
                      /// AuthButton 안의 FractionallySizedBox 가 문제를 일으킴
                      /// 해결법 Expanded 로 감싸기
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _onEmailTap(context),
                          child: AuthButton(
                            icon: FaIcon(FontAwesomeIcons.user),
                            text: S.of(context).emailPasswordBtn,
                          ),
                        ),
                      ),
                      Gaps.h16,
                      Expanded(
                        child: GestureDetector(
                          onTap: () => ref
                              .read(socialAuthProvider.notifier)
                              .githubSignIn(context),
                          child: AuthButton(
                            icon: FaIcon(FontAwesomeIcons.github),
                            text: S.of(context).githubSignUpBtn,
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: ref.watch(themeConfigProvider).isDark
              ? null
              : Colors.grey.shade50,
          clipBehavior: Clip.none,
          child: Padding(
            padding: const EdgeInsets.only(
              top: Sizes.size32,
              bottom: Sizes.size64,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).alreadyHaveAnAccount,
                ),
                Gaps.h5,
                GestureDetector(
                  onTap: () => _onLoginTap(context),
                  child: Text(
                    // S.of(context).logIn("male"), // selection
                    "Log in",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
