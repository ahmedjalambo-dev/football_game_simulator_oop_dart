import '../models/team.dart';
import '../models/stadium.dart';

/// Defines the contract for any factor that can modify a team's power.
abstract class PowerModifier {
  String get name;
  int calculate(Team myTeam, Team opponentTeam, Stadium stadium);
}
