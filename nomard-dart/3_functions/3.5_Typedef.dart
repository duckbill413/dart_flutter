typedef ListOfInts = List<int>; // List<int>의 타입

ListOfInts reverseListOfNumbers(List<int> list) {
  var reversed = list.reversed;
  return reversed.toList();
}

void main() {
  print(reverseListOfNumbers([1, 2, 3, 4, 5]));

  Set<(int, int)> point = {(1, 2), (2, 3), (3, 4), (4, 5)};
  point.addAll([(1, 2), (2, 3)]);
  print(point);
}
