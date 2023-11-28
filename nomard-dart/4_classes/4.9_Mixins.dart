// Mixin은 생성자가 없는 클래스여야 한다.
// class는 mixin class의 property를 단순히 뻇어오기만 한다.
mixin Strong {
  final double strengthLevel = 1500.99;
}

mixin QuickRunner {
  void runQuick() {
    print('ruuuuuuuuuuuuuuuun');
  }
}

mixin Tall {
  final double height = 1.99;
}

enum Team { red, blue }

class Horse with Strong, QuickRunner {}

class Kid with QuickRunner {}

class Player with Strong, QuickRunner, Tall {
  final Team team;

  Player({required this.team});
}

void main() {}
