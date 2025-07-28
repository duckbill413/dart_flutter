import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // 본격적으로 테스트가 시작되기 전에 실행되는 함수
  setUp(() {});

  // 테스트가 완료된 이후에 실행되는 함수
  tearDown(() => null);
}
