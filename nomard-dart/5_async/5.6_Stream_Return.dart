import 'dart:async';

Stream<String> calc() async* {
  for (int i = 0; i < 5; i++) {
    yield 'i = $i';
    await Future.delayed(Duration(seconds: 1));
  }
}

void playStream() {
  calc().listen((val) {
    print(val);
  });
}

void main() {
  playStream();
}
