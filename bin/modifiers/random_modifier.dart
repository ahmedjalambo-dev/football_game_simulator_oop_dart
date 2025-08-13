import 'dart:math';

import 'power_modifier.dart';
import '../models/team.dart';
import '../models/stadium.dart';

/// Adds a random factor to the power calculation.
class RandomModifier extends PowerModifier {
  @override
  String get name => 'Random Factor';

  @override
  int calculate(Team myTeam, Team opponentTeam, Stadium stadium) {
    return Random().nextInt(25);
  }
}
