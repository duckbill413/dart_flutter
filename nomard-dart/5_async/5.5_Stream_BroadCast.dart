/// Stream은 한 번만 listen()을 수행할 수 있습니다. 하지만 때때로 하나의 스트림을 생성하고 여러 번 listen() 함수를 실행하고 싶을 때가 있습니다.
/// 이럴 때 broadcast stream을 사용하면 Stream을 여러 번 listen() 하도록 변환할 수 있습니다.
import 'dart:async';

void main() {
  final controller = StreamController();
  // 여러번 listen할 수 있는 Broadcast Stream 객체 생성
  final stream = controller.stream.asBroadcastStream(); // stream 가져오기

  final streamListener1 = stream.listen((val) {
    print('listening 1: $val');
  });

  final streamListener2 = stream.listen((val) {
    print('listening 2: $val');
  });

  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);
  controller.sink.add(4);
  controller.sink.add(5);
}
