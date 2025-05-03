import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({super.key});

  @override
  BirthdayScreenState createState() => BirthdayScreenState();
}

class BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  DateTime initDate = DateTime.now();
  DateTime maxDate = DateTime.now().add(const Duration(days: -(365 * 12)));
  final regExp = RegExp(r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$');

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initDate);
    _birthdayController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  bool isValidDate(String date) {
    return regExp.hasMatch(date);
  }

  void _onNextTap() {
    ref.read(signUpForm.notifier).state["birthday"] =
        _birthdayController.value.text;
    ref.read(signUpProvider.notifier).signUp(context);
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            Text(
              "When's your birthday?",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: Sizes.size24,
              ),
            ),
            Gaps.v8,
            Text(
              "Your birthday won't be shown publicly.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _birthdayController,
              decoration: InputDecoration(
                hintText: "Birthday",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v28,
            FormButton(
              onTap: _onNextTap,
              disabled: _birthdayController.value.text.isEmpty ||
                  !isValidDate(_birthdayController.value.text) ||
                  ref.watch(signUpProvider).isLoading,
              text: "Next",
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 300,
        child: CupertinoDatePicker(
          maximumDate: maxDate,
          initialDateTime: maxDate,
          onDateTimeChanged: _setTextFieldDate,
          mode: CupertinoDatePickerMode.date,
        ),
      ),
    );
  }
}
