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

  // where 함수
  final scoreUnder30List = score.where((s) => s <= 30).toList();
  print(scoreUnder30List);
  // map 함수
  final plus20ToScore = score.map((s) => s + 20).toList();
  print(plus20ToScore);
  // reduce 함수 (누적, 구성하는 값들의 타입과 반환되는 리스트를 구성할 값의 타입이 같아야한다.)
  var blackPinkList = ['리사', '지수', '제니', '로제'];
  final allMembers =
      blackPinkList.reduce((value, element) => value + ', ' + element);
  print(allMembers);
  // fold 함수
  final total = score.fold<int>(0, (value, element) => value + element);
  print(total);
}
