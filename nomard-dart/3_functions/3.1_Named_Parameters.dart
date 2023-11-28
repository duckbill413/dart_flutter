// country에 default value korea 지정
// required를 통해 null 허용 X
// ?를 통해 null을 허용
String sayHello({
  required String name,
  int? age,
  String country = 'korea',
}) {
  return "Helllo $name, you are $age, and you com from $country";
}

void main() {
  print(sayHello(
    name: 'duckbill',
    age: 28,
  ));
}
