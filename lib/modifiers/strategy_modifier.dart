import '../core/enums.dart';
import '../models/team.dart';
import '../models/stadium.dart';
import 'power_modifier.dart';

/// Calculates bonus based on strategy matchup.
class StrategyModifier extends PowerModifier {
  @override
  String get name => 'Strategy Bonus';

  @override
  int calculate(Team myTeam, Team opponentTeam, Stadium stadium) {
    if (myTeam.strategy == Strategy.offensive) {
      if (opponentTeam.strategy == Strategy.defensive) return 5;
      if (opponentTeam.strategy == Strategy.dalanced) return 15;
      if (opponentTeam.strategy == Strategy.offensive) return 10;
    }
    if (myTeam.strategy == Strategy.defensive) {
      if (opponentTeam.strategy == Strategy.offensive) return 20;
      if (opponentTeam.strategy == Strategy.dalanced) return 10;
      if (opponentTeam.strategy == Strategy.defensive) return 5;
    }
    if (myTeam.strategy == Strategy.dalanced) {
      if (opponentTeam.strategy == Strategy.offensive) return 5;
      if (opponentTeam.strategy == Strategy.defensive) return 5;
      if (opponentTeam.strategy == Strategy.dalanced) return 15;
    }
    return 0;
  }
}
