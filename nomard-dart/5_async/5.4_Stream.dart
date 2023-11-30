/// Future은 반환값을 딱 한 번 받아내는 비동기 프로그래밍에 사용합니다.
/// 지속적으로 반환값을 받을 때는 Stream을 사용합니다.
/// Stream은 한 번 listen 하면 Stream에 주입된느 모든 값들을 지속적으로 받아옵니다.
/// Future.wait() 함수는 하나의 Future로 구성된 리스트를 매개변수로 입력받습니다. Future.wait()에 입력된 비동기 함수들은 모두 동시에 실행되면 응답값을 요청을 보낸 순서대로 저장해 둡니다.
import 'dart:async';

void main() {
  final controller = StreamController();
  final stream = controller.stream; // stream 가져오기

  final streamListener1 = stream.listen((val) {
    print(val);
  });

  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);
  controller.sink.add(4);
  controller.sink.add(5);
}
