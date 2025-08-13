import 'dart:math';
import 'person.dart';

/// Represents a single player, inheriting from Person.
class Player extends Person {
  String position;
  int id;
  int power;
  int stamina;

  Player(super.name, this.position, this.id)
    : power = Random().nextInt(50) + 50,
      stamina = Random().nextInt(30) + 70;

  @override
  void display() {
    print(
      '    - Player ID: $id, Name: $name, Position: $position, Power: $power, Stamina: $stamina',
    );
  }
}
