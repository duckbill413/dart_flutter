# tiktok

nomadcoders tiktok clone coding project

Flutter Android license 적용

```shell
flutter doctor --android-licenses
```

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

### GoRouter

https://pub.dev/packages/go_router/install

## 19 VIDEO RECORDING

> ## Iphone Build App Error
> ![아이폰 에러](docs/iphone_error1.png)  
> `cd ./ios`  
> `rm -rf Pods`    
> `rm -rf Podfile.lock`   
> `pod install`  
> `xcode` => `shift + command + K`
>
> `pod repo update`

### 앱 빌드를 위한 아이폰 세팅

1. `ios/Runner/Info.plist`
2. `ios/Podfile`

위의 파일 수정을 통해 카메라 및 마이크 권한 부여 설정

### 앱 빌드를 위한 안드로이드 세팅

1. `android/gradle.properties`

    ```
    android.useAndroidX=true
    android.enableJetifier=true
    ```

2. `android/app/build.gradle`

    ```
    android {
      compileSdkVersion 33
      ...
    }
    ```

> `exportSyncFdForQSRILocked` 로그가 지속적으로 발생하는 경우
> `flutter run --no-enable-impeller`  또는
> Edit Configuration 에서 `Additional run args` 에
> `--no-enable-impeller` 옵션 추가

## 22. Firebase Setup

https://firebase.google.com/docs/flutter/setup

### 23.1 Installation

1. Install Firebase-Cli
   ```shell
   curl -sL https://firebase.tools | bash
   ```
2. Firebase login
   ```shell
   firebase login
   ```
3. Install the `FlutterFire CLI`
   ```shell
   dart pub global activate flutterfire_cli
   ```
4. Configure your apps to use Firebase

   > zsh: command not found: flutterfire  
   > 위와 같은 오류 발생시  
   > `vi ~/.zshrc`  
   > 맨 아래에 `export PATH="$PATH:$HOME/.pub-cache/bin"` 추가  
   > `source ~/.zshrc`

   ```shell
   flutterfire configure
   ```

- firebase 플러그인을 추가/제거할 때마다 위의 명령을 실행해 주어야 함.

![img.png](docs/firebase_plugin_setup.png)

- https://firebase.google.com/docs/flutter/setup

## 24 FIREBASE AUTHENTICATION

### 24.3 Social Auth Config

- Android 의 경우 세팅

1. `./gradlew signinReport` 콘솔에 입력

- IOS setting

https://firebase.google.com/docs/auth/ios/github-auth?hl=ko

- XCode 수정
  ![img.png](docs/ios-setting.png)
- URL Scheme 정보 위치
  ![ios-setting2.png](docs/ios-setting2.png)

## 26 VIDEO UPLOAD

### 26.3 Cloud Functions

- Firebase cloud Function setup

```shell
firebase init functions
```

1. Use an existing Project
2. Select a default Firebase project (tiktok)
3. What language would you like to use to write cloud functions (TypeScript)
4. Do you want to use ESLint to catch probable bugs and enforce style? (no)
   Do you want to install dependencies with npm now? (yes)

- Firebase Function Script

```ts
import * as functions from "firebase-functions"
import * as admin from "firebase-admin"

admin.initializeApp();

export const onVideoCreated = functions.firestore.onDocumentCreated(
    {
        document: "videos/{videoId}",
        region: "asia-northeast3",
    },
    async (event) => {
        const snapshot = event.data;
        if (!snapshot) return;
        await snapshot.ref.update({"hello": "from functions"});
    });
```

위와 같이 스크립트 작성후 Functions 에 배포

```shell
firebase deploy --only functions
```

> 잘 안되는 경우 `functions` 폴더에서 `npm run build` 를 먼저 실행
> firebase.json 파일 참조

### 26.4 ffmpeg

- child-process-promise 설치

1. `cd functions`
2. `npm i child-process-promise`

## 29 PUSH NOTIFICATIONS

1. Install FCM plugin

```bash
flutter pub add firebase_messaging
```

2. Initialize Flutter Configure

```bash
flutterfire configure
```

IOS 알림 테스트  
https://velog.io/@tygerhwang/Flutter-Firebase-FCMFirebase-Cloud-Message-사용해-보기

## 29 PUSH NOTIFICATION

1. Foreground Messaging
   ![img.png](assets/images/message-foreground1.png)
   ![img.png](assets/images/message-foreground2.png)
2. Background Messaging
   ![img.png](assets/images/message-background1.png)
   ![img_1.png](assets/images/message-background2.png)
   ![img_2.png](assets/images/message-background3.png)

## 30 SECURITY AND TESTING

### 30.1 Security Rules

- Cloud Firestore 의 규칙에서 Firestore 의 Security 규칙을 생성할 수 있음

```shell
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.time < timestamp.date(2026, 5, 31);
    }
  }
}
```

- `write` 는 `update`, `create`, `delete` 를 허용하는 규칙

규칙 변경

1. 본인의 데이터를 본인만 수정할 수 있도록 규칙 변경
2. 로그인 사용자만 비디오 read, create 가능
3. 본인의 업로드 비디오만 수정 가능

```shell
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.time < timestamp.date(2026, 5, 31);
    }
    match /users/{document=**} {
    	allow read, update, create : if request.auth != null && resource.id == request.auth.uid;
    }
    match /videos/{document=**} {
    	allow read, create : if request.auth != null;
      allow update: if request.auth != null && request.auth.uid == resource.data.creatorUid;
    }
  }
}
```

