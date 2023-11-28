void main() {
  var numbers = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
  ];
  List<int> nums = [1, 2, 3, 4, 5, 6, 7, 8];

  numbers.add(12);

  // collection if를 사용하면 `존재할 수도 안할 수도 있는 요소를 가지고 올 수 있다.`
  var giveMeFifteen = true;
  var score = [
    10,
    20,
    30,
    40,
    if (giveMeFifteen) 50,
  ];
}
