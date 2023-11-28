class Player {
  final String name;
  String team;
  int xp, age;

  // default contructor
  Player({
    required this.name,
    required this.xp,
    required this.team,
    required this.age,
  });

  Player.createRedPlayer({
    required String name,
    required int age,
  })  : this.age = age,
        this.name = name,
        this.team = 'red',
        this.xp = 0;

  Player.createBluePlayer({
    required this.name,
    required this.xp,
    this.team = 'blue',
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

  var redPlayer = Player.createRedPlayer(
    name: "red duck",
    age: 12,
  );

  print(redPlayer);
}
