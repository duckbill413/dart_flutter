void main() {
  var giveMeFive = true;
  var numbers = [
    1,
    2,
    3,
    4,
    if (giveMeFive) 5, // collectino if
  ]; // 마지막에 쉼표를 붙여 가시성을 높힐 수 있다.
  List<int> intNumbers = [1, 2, 3, 4];

  numbers.add(10);

  print(numbers);
}
