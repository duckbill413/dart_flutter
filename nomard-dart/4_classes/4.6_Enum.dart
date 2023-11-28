enum Team { red, blue }

enum XPLevel {
  level1("beginner"),
  level2("medium"),
  level3("pro");

  const XPLevel(this.value);
  final String value;
}

class Player {
  String name;
  XPLevel level;
  Team team;

  Player({
    required this.name,
    required this.level,
    required this.team,
  });

  void sayHello() => print('$name, ${level.value}, $team');
}

void main() {
  var duckbill = Player(
    name: 'duckbill',
    level: XPLevel.level2,
    team: Team.red,
  ) // 앞에 클래스가 있다면 곧바로 그 class를 가리키게 된다.
    ..name = 'duck'
    ..level = XPLevel.level3
    ..team = Team.blue;
  duckbill.sayHello();

  var rabbit = duckbill
    ..name = 'rabbit'
    ..level = XPLevel.level1
    ..sayHello();
  duckbill.sayHello();
}
