void main() {
  // Ex) String 뒤에 ?를 붙여줌으로서 String이 null이 될 수 있다고 명시
  String? name = 'duckbill';
  name = null;
  if (name != null) {
    print(name);
  }
  else{
    print('name is null');
  }
}