import 'package:flutter/material.dart';

class Player {
  String name;

  Player({
    required this.name,
  });
}

void main() {
  var duckbill = Player(
    name: 'duckbill',
  );
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // widget에는 material: goolge과 cupertino: ios type이 있다.
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello flutter!'),
        ),
        body: Center(
          child: Text('Hello world!!!'),
        ),
      ),
    );
  }
}
