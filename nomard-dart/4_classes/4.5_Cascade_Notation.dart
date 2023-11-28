class Player {
  String name, team;
  int xp;

  Player({
    required this.name,
    required this.xp,
    required this.team,
  });

  void sayHello() => print('$name, $xp, $team');
}

void main() {
  var duckbill = Player(
    name: 'duckbill',
    xp: 1000,
    team: 'red',
  ) // 앞에 클래스가 있다면 곧바로 그 class를 가리키게 된다.
    ..name = 'duck'
    ..xp = 2000
    ..team = 'blue';
  duckbill.sayHello();

  var rabbit = duckbill
    ..name = 'rabbit'
    ..sayHello();
  duckbill.sayHello();
}
