void main() {
  // dart의 변수는 기본적으로 nullable이 아니다.
  // nullable 변수의 생성
  String? name1 = "duckbill";
  name1 = null;

  // String의 isBlank 체크
  if (name1 != null) {
    name1.isNotEmpty;
  }
  // 이렇게도 가능
  print(name1?.isEmpty);
}
