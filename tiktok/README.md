# tiktok

nomadcoders tiktok clone coding project

## 16 Intl

### 16.4 Flutter Intl

`Flutter Intl` plugin 을 사용하여 간단하게 프로젝트에서 Intl 을 사용할 수 있음

- `intellij` 기준 `shift + shift` 입력 시 `flutter intl` 검색
- `Flutter Intl` 을 실행하여 프로젝트를 초기화
- 필요한 Locale 에 대하여 `Add Locale` 을 통해 추가

```dart
@override
Widget build(BuildContext context) {
  return MaterialApp(
    localizationsDelegates: [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      Locale("en"),
      Locale("kr"),
      Locale("es"),
    ],
  );
}
```

### 16.6 Numbers l10n

intl 파일에서 사용가능한 `format` 형식
https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#messages-with-numbers-and-currencies

### 16.7 Date l10n

intl 파일에서 사용 가능한 다양한 `DateTime` format
https://api.flutter.dev/flutter/intl/DateFormat-class.html

## 18 NAVIGATOR 2

flutter 에서 `named route` 는 지양되고 있음

- https://docs.flutter.dev/cookbook/navigation/named-routes
- browser 환경에서 `forward`가 동작하지 않음