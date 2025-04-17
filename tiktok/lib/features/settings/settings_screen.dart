import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/common/widgets/video_config/video_config.dart';

// #13.0 ListWheelScrollView
// 닫기 버튼을 쉽게 만들 수 있는 위젯
// CloseButton(),

// apple, android 로딩 상태바
// CupertinoActivityIndicator()
// CircularProgressIndicator()
// OS 에 따라서 다른 로딩 상태바 제공
// CircularProgressIndicator.adaptive()

// 13.1 AboutListTile
// ListTile(
//   // 앱 배포시 필요한 오픈소스 라이선스 고지를 쉽게할 수 있음
//   onTap: () => showAboutDialog(
//     context: context,
//     applicationVersion: "1.0",
//     applicationLegalese: "All rights reserved. please don't copy me",
//   ),
//   title: Text(
//     "About",
//     style: TextStyle(
//       fontWeight: FontWeight.w600,
//     ),
//   ),
//   subtitle: Text("About this app...."),
// ),

// AboutListTile

/// #13.2 showDateRangePicker
// /// 1. showDatePicker
// /// 2. showTimePicker
// /// 3. showDateRangePicker
// ListView(
//   children: [
//     ListTile(
//       onTap: () async {
//         final date = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(1980),
//           lastDate: DateTime(2030),
//         );
//         print(date);
//
//         final time = await showTimePicker(
//           context: context,
//           initialTime: TimeOfDay.now(),
//         );
//         print(time);
//
//         final booking = await showDateRangePicker(
//           context: context,
//           builder: (context, child) {
//             return Theme(
//               data: ThemeData(
//                 appBarTheme: AppBarTheme(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.black,
//                 ),
//               ),
//               child: child!,
//             );
//           },
//           firstDate: DateTime(1980),
//           lastDate: DateTime(2030),
//         );
//         print(booking);
//       },
//       title: Text("What is your birthday?"),
//     )
//   ],
// ),

// #13.3 SwitchListTile
// 1. Checkbox
// 2. CheckboxListTile
// 3. Switch
// 4. Switch.adaptive
// 5. SwitchListTile
// 6. CupertinoSwitch
//
// Checkbox(
//   value: _notifications,
//   onChanged: _onNotificationChanged,
// ),
// CheckboxListTile(
//   value: _notifications,
//   onChanged: _onNotificationChanged,
//   title: Text("Enable notifications!"),
//   activeColor: Colors.black,
//   checkColor: Colors.white,
// ),
// Switch(
//   value: _notifications,
//   onChanged: _onNotificationChanged,
// ),
// Switch.adaptive(
//   value: _notifications,
//   onChanged: _onNotificationChanged,
// ),
// SwitchListTile(
//   value: _notifications,
//   onChanged: _onNotificationChanged,
// ),
// CupertinoSwitch(
//   value: _notifications,
//   onChanged: _onNotificationChanged,
// ),

// 13.4 CupertinoAlertDialog
// 1. showCupertinoDialog
//    - CupertinoAlertDialog
//    - CupertinoDialogAction
// 2. showDialog
//    - AlertDialog
//
// ListView(
//   children: [
//     ListTile(
//       title: Text(
//         "Log out (iOS)",
//       ),
//       textColor: Colors.red,
//       onTap: () {
//         showCupertinoDialog(
//           context: context,
//           builder: (context) => CupertinoAlertDialog(
//             title: Text("Are you sure?"),
//             content: Text("Plx don't go"),
//             actions: [
//               CupertinoDialogAction(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text("No"),
//               ),
//               CupertinoDialogAction(
//                 onPressed: () => Navigator.of(context).pop(),
//                 isDestructiveAction: true,
//                 child: Text("Yes"),
//               )
//             ],
//           ),
//         );
//       },
//     ),
//     ListTile(
//       title: Text(
//         "Log out (Android)",
//       ),
//       textColor: Colors.red,
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             icon: FaIcon(FontAwesomeIcons.skull),
//             title: Text("Are you sure?"),
//             content: Text("Plx don't go"),
//             actions: [
//               IconButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 icon: FaIcon(FontAwesomeIcons.car),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text("Yes"),
//               )
//             ],
//           ),
//         );
//       },
//     )
//   ],
// ),

// 13.5 CupertinoActionSheet
// 1. showCupertinoModalPopup
// 2. CupertinoActionSheet
// 3. CupertinoDialogAction
//
// ListTile(
//   title: Text(
//     "Log out (iOS / Bottom)",
//   ),
//   textColor: Colors.red,
//   onTap: () {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (context) => CupertinoActionSheet(
//         title: Text("Are you sure?"),
//         message: Text("Plz don't go..."),
//         actions: [
//           CupertinoDialogAction(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text("No"),
//           ),
//           CupertinoDialogAction(
//             onPressed: () => Navigator.of(context).pop(),
//             isDestructiveAction: true,
//             child: Text("Yes"),
//           ),
//         ],
//       ),
//     );
//   },
// ),

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: const Locale("es"),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ListView(
          children: [
            SwitchListTile.adaptive(
              value: VideoConfigData.of(context).autoMute,
              onChanged: (value) => VideoConfigData.of(context).toggleMuted(),
              title: const Text("Auto Mute Videos"),
              subtitle: const Text("Videos will be muted by default"),
            ),
            SwitchListTile.adaptive(
              value: _notifications,
              onChanged: _onNotificationsChanged,
              title: const Text("Enable notifications"),
              subtitle: const Text("They will be cute."),
            ),
            CheckboxListTile(
              activeColor: Colors.black,
              value: _notifications,
              onChanged: _onNotificationsChanged,
              title: const Text("Marketing emails"),
              subtitle: const Text("We won't spam you."),
            ),
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                );
                if (kDebugMode) {
                  print(date);
                }
                if (!mounted) return;
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (kDebugMode) {
                  print(time);
                }
                if (!mounted) return;
                final booking = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData(
                          appBarTheme: const AppBarTheme(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black)),
                      child: child!,
                    );
                  },
                );
                if (kDebugMode) {
                  print(booking);
                }
              },
              title: const Text("What is your birthday?"),
              subtitle: const Text("I need to know!"),
            ),
            ListTile(
              title: const Text("Log out (iOS)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text("Are you sure?"),
                    content: const Text("Plx dont go"),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("No"),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        isDestructiveAction: true,
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (Android)"),
              textColor: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const FaIcon(FontAwesomeIcons.skull),
                    title: const Text("Are you sure?"),
                    content: const Text("Plx dont go"),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const FaIcon(FontAwesomeIcons.car),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (iOS / Bottom)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const Text("Are you sure?"),
                    message: const Text("Please dooooont gooooo"),
                    actions: [
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Not log out"),
                      ),
                      CupertinoActionSheetAction(
                        isDestructiveAction: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Yes plz."),
                      )
                    ],
                  ),
                );
              },
            ),
            const AboutListTile(
              applicationVersion: "1.0",
              applicationLegalese: "Don't copy me.",
            ),
          ],
        ),
      ),
    );
  }
}
