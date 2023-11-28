// ignore_for_file: public_member_api_docs, sort_constructors_first
class Human {
  final String name;
  Human({required this.name});

  void sayHello() {
    print('Hi my name is $name');
  }
}

class Player extends Human {
  final Team team;

  Player({
    required this.team,
    required String name,
  }) : super(name: name);

  @override
  void sayHello() {
    super.sayHello();
    print('Let\'s play!!!');
  }
}

enum Team { red, blue }

void main() {
  var player = Player(team: Team.red, name: 'duckbill');
  player.sayHello();
}
