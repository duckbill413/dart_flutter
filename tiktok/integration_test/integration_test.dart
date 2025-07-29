import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tiktok/firebase_options.dart';
import 'package:tiktok/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // 본격적으로 테스트가 시작되기 전에 실행되는 함수
  setUp(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // 로그아웃 상태로 테스트 진행
    await FirebaseAuth.instance.signOut();
  });

  testWidgets("Create Account Flow", (WidgetTester tester) async {
    await tester.pumpWidget(
      // Riverpod 과 같은 provider 설정
      ProviderScope(
        child: TiktokApp(),
      ),
    );
    // 앱 실행중 애니메이션 효과등은 스킵하고 최종 프레임만 렌더링
    await tester.pumpAndSettle();
    expect(find.text("틱톡 회원가입"), findsOneWidget);
    final login = find.text("Log in");
    expect(login, findsOneWidget);
    await tester.tap(login);
    await tester.pumpAndSettle(const Duration(seconds: 10));
    final signUp = find.text("Sign up");
    expect(signUp, findsOneWidget);
    await tester.tap(signUp);
    await tester.pumpAndSettle();
    final emailBtn = find.text('Use email & password');
    expect(emailBtn, findsOneWidget);
    await tester.tap(emailBtn);
    await tester.pumpAndSettle();
  });

  // 테스트가 완료된 이후에 실행되는 함수
  // tearDown(() => null);
}
