void main() async {
  final result = await addNumbers(1, 1, 5);
  final result2 = await addNumbers(2, 2, 3);
  print('$result , $result2');
}

// async 키워드는 함수 매개변수 정의와 바디 사이에 입력합니다.
Future<int> addNumbers(int num1, int num2, int time) async {
  print('$num1 + $num2 계산시작!');

  await Future.delayed(Duration(seconds: time), () {
    print('$num1 + $num2 = ${num1 + num2}');
  });

  print('$num1 + $num2 코드 실행 끝!');
  return num1 + num2;
}
