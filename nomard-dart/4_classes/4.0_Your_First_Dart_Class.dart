class Player {
  String? name;
  int xp = 0;

  void sayHello() {
    print("Hello my name is $name");
  }
}

void main() {
  var player = Player();
  player.name = "duckbill";
  print(player);
  player.sayHello();
}
