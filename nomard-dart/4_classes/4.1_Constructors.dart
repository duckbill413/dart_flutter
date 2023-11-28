class Player {
  final String name;
  int xp;

  Player(this.name, this.xp);
}

void main() {
  var player = Player("duckbill", 3000);
  print(player);
}
