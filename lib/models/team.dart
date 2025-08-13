import 'trainer.dart';
import 'player.dart';
import '../core/enums.dart';

/// Represents a football team
class Team {
  String name;
  String mascot;
  Trainer trainer;
  List<Player> players;
  Strategy strategy;
  int totalPower = 0; // To store the final calculated power

  Team(this.name, this.mascot, this.trainer, this.players, this.strategy);

  int get basePower {
    int playersPower = players.fold(0, (sum, player) => sum + player.power);
    return playersPower + trainer.experience;
  }

  void display() {
    print('--- Team: $name (Mascot: $mascot) ---');
    trainer.display();
    print('  > Strategy: ${strategy.name}');
    print('  > Players:');
    for (var player in players) {
      player.display();
    }
    print('--------------------------------------\n');
  }
}
