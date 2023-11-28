void main() {
  var oldFriends = [
    'tiger',
    'elephant',
  ];
  var newFriends = [
    'rabbit',
    'cat',
    'dog',
    for (var friend in oldFriends) '❤️ $friend'
  ];
  print(newFriends);
}
