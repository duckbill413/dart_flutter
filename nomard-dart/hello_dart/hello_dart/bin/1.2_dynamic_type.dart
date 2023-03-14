void main() {
  // 변수를 선언할 때 dynamic을 쓰거나 지정하지 않으면 dynamic type을 가진다.
  dynamic name;
  name = 'duckbill';

  if (name is String) {
    if (name.startsWith("duck")) {
      print("duck HI ~~");
    }
  }
}
