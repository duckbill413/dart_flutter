import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';
import 'package:tiktok/features/onboarding/interests_screen.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();
  final DateTime _initialDate =
      DateTime.now().subtract(const Duration(days: 365 * 12));

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(_initialDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InterestsScreen(),
      ),
    );
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(' ').first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign up",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'When\'s your birthday?',
                        style: TextStyle(
                          fontSize: Sizes.size24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Gaps.v8,
                      Text(
                        'Your birthday won\'t be shown publicly',
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.cakeCandles),
                    ],
                  )
                ],
              ),
              Gaps.v16,
              TextField(
                enabled: false,
                controller: _birthdayController,
                keyboardType: TextInputType.visiblePassword,
                autocorrect: false,
                onEditingComplete: _onSubmit,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  )),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v10,
              const Text(
                'Your password must have',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v28,
              FormButton(
                disabled: false,
                onTap: _onSubmit,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 300,
          surfaceTintColor: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: _setTextFieldDate,
            dateOrder: DatePickerDateOrder.ymd,
            maximumDate: _initialDate,
            initialDateTime: _initialDate,
          ),
        ),
      ),
    );
  }
}
