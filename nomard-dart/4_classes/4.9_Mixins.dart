// 생성자가 없는 클래스
class Strong {
  final double strengthLevel = 1500.99;
}

class QuickRunner {
  void runQuick() {
    print('ruuuuuuuuuuuuuuuun');
  }
}

enum Team { red, blue }

class Player {
  final Team team;

  Player({required this.team});
}

void main() {}
