class Player {
  final String name;
  int xp;
  String team;
  int age;

  Player({
    required this.name,
    required this.xp,
    required this.team,
    required this.age,
  });
}

void main() {
  var player = Player(
    name: 'duckbill',
    xp: 3000,
    team: 'red',
    age: 25,
  );
  print(player);
}
