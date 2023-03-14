void main(){
  /* late 변수
  초기 데이터 없이 머저 변수를 생성하고 추후에 데이터를 넣을 때 주로 사용
  데이터를 할당하지 않을 경우 사용하지 못하도록 막아주는 역할도 한다.
  flutter의 data fetching을 할 때 유용하게 사용된다.

  */
  late final String name;
  name = 'duckbill';

  print(name);

  late var lateType;
  lateType = 'late type duckbill';
  print(lateType);
}