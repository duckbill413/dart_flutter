import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/username_screen.dart';
import 'package:tiktok/features/authentication/widgets/auth_button.dart';
import 'package:tiktok/utils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _onEmailSignUpTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      print(orientation); // Orientation.portrait
      if (orientation == Orientation.landscape) {
        return Scaffold(
          body: Center(
            child: Text("Plz rotate ur phone!"),
          ),
        );
      }
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
                  'Sign up for Tiktok',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Gaps.v20,
                Opacity(
                  opacity: 0.7,
                  child: Text(
                    'Create a profile, follow other accounts, make your own videos, and more.',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Gaps.v40,
                if (orientation == Orientation.portrait) ...[
                  AuthButton(
                    icon: FaIcon(FontAwesomeIcons.user),
                    text: "Use email & password",
                    onTap: _onEmailSignUpTap,
                  ),
                  Gaps.v16,
                  AuthButton(
                    icon: FaIcon(FontAwesomeIcons.apple),
                    text: "Continue with Apple",
                    onTap: () => {},
                  ),
                ],
                if (orientation == Orientation.landscape)
                  Row(
                    children: [
                      /// AuthButton 안의 FractionallySizedBox 가 문제를 일으킴
                      /// 해결법 Expanded 로 감싸기
                      Expanded(
                        child: AuthButton(
                          icon: FaIcon(FontAwesomeIcons.user),
                          text: "Use email & password",
                          onTap: _onEmailSignUpTap,
                        ),
                      ),
                      Gaps.h16,
                      Expanded(
                        child: AuthButton(
                          icon: FaIcon(FontAwesomeIcons.apple),
                          text: "Continue with Apple",
                          onTap: () => {},
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: isDarkMode(context) ? null : Colors.grey.shade50,
          clipBehavior: Clip.none,
          shadowColor: Colors.black,
          surfaceTintColor: Colors.grey.shade50,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                Gaps.h5,
                GestureDetector(
                  onTap: () => _onLoginTap(context),
                  child: Text(
                    'Log in',
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
