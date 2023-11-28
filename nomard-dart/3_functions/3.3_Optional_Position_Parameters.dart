String sayHello(String name, int age, [String? country = 'korea']) =>
    'Hello $name, you are $age, you are $country';

void main() {
  print(sayHello('duckbill', 25));
}
