import '../core/input_handler.dart';
import '../models/team.dart';
import '../models/stadium.dart';
import '../models/trainer.dart';
import '../models/player.dart';
import '../modifiers/power_modifier.dart';
import '../modifiers/strategy_modifier.dart';
import '../modifiers/weather_modifier.dart';
import '../modifiers/random_modifier.dart';
import '../core/enums.dart';

/// Manages the entire game simulation
class Game {
  late Team team1;
  late Team team2;
  late Stadium stadium;
  late List<PowerModifier> powerModifiers;

  Game() {
    // [POLYMORPHISM] Initialize a list of different power modifiers.
    powerModifiers = [StrategyModifier(), WeatherModifier(), RandomModifier()];
  }

  void setup() {
    print('⚽ Welcome to the Football Game Simulator! ⚽\n');
    print('--- Setup Team 1 ---');
    team1 = _createTeam(1);
    print('\n--- Setup Team 2 ---');
    team2 = _createTeam(2);
    print('\n--- Setup Stadium ---');
    stadium = _createStadium();
  }

  void simulate() {
    print('\n\n KICK OFF! THE MATCH IS ABOUT TO BEGIN!');
    print('============================================');
    stadium.display();
    team1.display();
    team2.display();

    _printWeatherEvent();

    // Calculate final power using the polymorphic list of modifiers
    _calculateTeamPower(team1, team2);
    _calculateTeamPower(team2, team1);

    // Announce the winner
    _announceWinner();
  }

  void _calculateTeamPower(Team teamToCalculate, Team opponentTeam) {
    print('--- Power Analysis for ${teamToCalculate.name} ---');
    int basePower = teamToCalculate.basePower;
    print('  Base Power (Players + Trainer): $basePower');

    int totalBonus = 0;
    // [POLYMORPHISM] Iterate through modifiers without knowing their concrete type.
    for (var modifier in powerModifiers) {
      int bonus = modifier.calculate(teamToCalculate, opponentTeam, stadium);
      totalBonus += bonus;
      print('  ${modifier.name}: $bonus');
    }

    teamToCalculate.totalPower = basePower + totalBonus;
    print('  --------------------------------');
    print('  TOTAL POWER: ${teamToCalculate.totalPower}\n');
  }

  void _announceWinner() {
    print('--- FINAL RESULT ---');
    if (team1.totalPower > team2.totalPower) {
      print('🏆 ${team1.name.toUpperCase()} WINS THE MATCH! 🏆');
    } else if (team2.totalPower > team1.totalPower) {
      print('🏆 ${team2.name.toUpperCase()} WINS THE MATCH! 🏆');
    } else {
      print('🤝 IT\'S A DRAW! A hard-fought match ends in a tie. 🤝');
    }
    print('====================\n');
  }

  void _printWeatherEvent() {
    switch (stadium.weather) {
      case WeatherCondition.rainy:
        print(
          "Weather Event: It's raining! The pitch is slick, favoring defensive play.\n",
        );
        break;
      case WeatherCondition.windy:
        print("Weather Event: It's windy! The ball is moving unpredictably.\n");
        break;
      case WeatherCondition.sunny:
        print("Weather Event: It's a beautiful sunny day for football!\n");
        break;
    }
  }

  Team _createTeam(int teamNumber) {
    String name = InputHandler.getString('Enter Team $teamNumber Name: ');
    String mascot = InputHandler.getString('Enter Team $teamNumber Mascot: ');
    String trainerName = InputHandler.getString('Enter Trainer Name: ');
    Trainer trainer = Trainer(trainerName);
    Strategy strategy = InputHandler.getStrategy();
    int numPlayers = InputHandler.getInt('Enter number of players: ', min: 5);

    List<Player> players = [];
    for (int i = 0; i < numPlayers; i++) {
      print('-- Player ${i + 1} --');
      String playerName = InputHandler.getString('  Name: ');
      String position = InputHandler.getString(
        '  Position (e.g., Striker, Goalkeeper): ',
      );
      players.add(Player(playerName, position, i + 1));
    }
    return Team(name, mascot, trainer, players, strategy);
  }

  Stadium _createStadium() {
    String name = InputHandler.getString('Enter Stadium Name: ');
    String location = InputHandler.getString('Enter Stadium Location: ');
    int capacity = InputHandler.getInt('Enter Stadium Capacity: ');
    return Stadium(name, location, capacity);
  }
}
