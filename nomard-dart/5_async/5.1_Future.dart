/// Fucture 클래스는 '미래'라는 단어의 의미대로 미래에 받아올 값을 뜻합니다.

void main() {
  addNumbers(1, 1);
}

void addNumbers(int num1, int num2) {
  print("$num1 + $num2 계산 시작!");

  Future.delayed(Duration(seconds: 3), () {
    print('$num1 + $num2 = ${num1 + num2}');
  });

  print('$num1 + $num2 코드 실행 끝!');
}
