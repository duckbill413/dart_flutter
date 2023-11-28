String capitalizeName(String? name) {
  if (name != null) {
    return name.toUpperCase();
  }
  return 'ANON';
}

String capitalizeName1(String? name) =>
    name != null ? name.toUpperCase() : 'ANON';

String capitalizeName2(String? name) => name?.toUpperCase() ?? 'ANON';

void main() {
  print(capitalizeName('duckbill'));
  print(capitalizeName1(null));
  print(capitalizeName2(null));

  String? name;
  name ??= 'duckbill'; // name이 null이므로 duckbill 할당
  name ??= 'duck'; // name이 duckbill로 null이 아니므로 duck이 할당되지 않는다.
  print(name);
}
