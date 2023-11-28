void main() {
  // 나중에 데이터를 할당할 변수를 미리 생성
  late final String name; // final 변수에 대해서 지연 초기화 가능

  name = "duckbill";
  // late의 역할은 이 변수에 대해서 값이 할당된 이후 사용될 수 있게 해주는 역할
  // API 작업에서 많이 사용하게 된다.
}
