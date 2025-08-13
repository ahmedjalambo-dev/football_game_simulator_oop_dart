import 'dart:math';

import 'person.dart';
import '../core/enums.dart';

/// Represents a team trainer, inheriting from Person.
class Trainer extends Person {
  int experience;
  Strategy strategySpecialty;

  Trainer(super.name)
    : experience = Random().nextInt(30) + 20,
      strategySpecialty =
          Strategy.values[Random().nextInt(Strategy.values.length)];

  @override
  void display() {
    print(
      '  > Trainer: $name, Experience: $experience, Specialty: ${strategySpecialty.name}',
    );
  }
}
