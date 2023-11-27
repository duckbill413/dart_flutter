void main() {
  // 변수를 선언하면서 아무것도 할당하지 않는 경우 dynamic variable로 생성
  var name1;
  name1 = '홍길등';
  print(name1);
  name1 = 12;
  print(name1);
  name1 = true;
  print(name1);

  dynamic name2;
  name2 = 1.1;
  print(name2);
  // 타입 체크
  if (name2 is double) {
    print('${name2} is double');
  }
}
