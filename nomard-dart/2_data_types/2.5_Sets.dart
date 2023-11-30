void main() {
  var set1 = {1, 2, 3, 4}; // Set
  Set<int> set2 = {1, 2, 3, 4};
  print(set2.contains(2));
  print(set2.toList());

  var blackPink = ['로제', '지수', '지수'];
  print(Set.from(blackPink));
}
