/// String interpolation은 text에 변수를 추가하는 방법
void main(){
  var name = "duckbill";
  var age = 10;
  var greeting = 'Hello my name is $name and I\'m ${age + 2}';

  print(greeting);

}