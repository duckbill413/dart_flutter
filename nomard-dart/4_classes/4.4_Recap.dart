class Player {
  final String name;
  int xp;
  String team;

  Player.fromJson(Map<String, dynamic> playerJson)
      : name = playerJson['name'],
        xp = playerJson['xp'],
        team = playerJson['team'];

  void sayHello() {
    print('$name, $xp, $team');
  }
}

void main() {
  var apiData = [
    {
      "name": "duckbill",
      "team": "red",
      "xp": 1000,
    },
    {
      "name": "kakaru",
      "team": "blue",
      "xp": 1200,
    },
    {
      "name": "robbit",
      "team": "red",
      "xp": 800,
    },
  ];

  apiData.forEach((playerJson) {
    var player = Player.fromJson(playerJson);
    player.sayHello();
  });
}
