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
