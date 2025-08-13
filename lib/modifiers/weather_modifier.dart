import 'dart:math';

import 'power_modifier.dart';
import '../models/team.dart';
import '../models/stadium.dart';
import '../core/enums.dart';

/// Calculates bonus based on weather conditions.
class WeatherModifier extends PowerModifier {
  @override
  String get name => 'Weather Bonus';

  @override
  int calculate(Team myTeam, Team opponentTeam, Stadium stadium) {
    switch (stadium.weather) {
      case WeatherCondition.rainy:
        if (myTeam.strategy == Strategy.defensive) return 15;
        break;
      case WeatherCondition.windy:
        return Random().nextInt(15);
      case WeatherCondition.sunny:
        break;
    }
    return 0;
  }
}
