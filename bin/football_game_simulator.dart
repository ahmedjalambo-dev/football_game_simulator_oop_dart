import 'dart:io';
import 'dart:math';

// =========================================================================
// CREATIVE FEATURE DESCRIPTION
// =========================================================================
// Invented Feature: Weather System
// This simulation includes a 'WeatherSystem' that adds an element of
// unpredictability. This is now implemented using an abstract PowerModifier
// class to better demonstrate OOP principles.
// =========================================================================

// =========================================================================
// OOP CONCEPTS APPLIED
// =========================================================================
// 1. Inheritance:
//    - A base 'Person' class is created.
//    - 'Player' and 'Trainer' classes now 'extend' Person, inheriting the
//      'name' property to reduce code duplication.
//
// 2. Abstraction & Polymorphism:
//    - An abstract class 'PowerModifier' is defined with a 'calculate' method.
//    - Concrete classes (StrategyModifier, WeatherModifier, RandomModifier)
//      implement this abstract class.
//    - The 'Game' class uses a list of 'PowerModifier' objects polymorphically
//      to calculate the total power, without needing to know the details of
//      each specific calculation.
//
// 3. Encapsulation & Single Responsibility:
//    - The logic for calculating each type of bonus is now encapsulated
//      within its own modifier class (e.g., WeatherModifier handles weather logic).
//    - This makes the 'Game' class cleaner and focuses it on managing the
//      overall simulation flow.
// =========================================================================

/// Enum for Team Strategies
enum Strategy { offensive, defensive, dalanced }

/// Enum for Weather Conditions
enum WeatherCondition { sunny, rainy, windy }

// =========================================================================
// UTILITY AND INPUT HANDLING
// =========================================================================

/// A utility class for handling user input
class InputHandler {
  static String getString(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync() ?? '';
  }

  static int getInt(String prompt, {int min = 1}) {
    while (true) {
      try {
        stdout.write(prompt);
        int? value = int.tryParse(stdin.readLineSync() ?? '');
        if (value != null && value >= min) {
          return value;
        }
        print(
          'Invalid input. Please enter a number greater than or equal to $min.',
        );
      } catch (e) {
        print('Invalid input. Please enter a valid number.');
      }
    }
  }

  static Strategy getStrategy() {
    while (true) {
      stdout.write('Choose a team strategy (Offensive, Defensive, Balanced): ');
      String input = (stdin.readLineSync() ?? '').toLowerCase();
      switch (input) {
        case 'offensive':
          return Strategy.offensive;
        case 'defensive':
          return Strategy.defensive;
        case 'balanced':
          return Strategy.dalanced;
        default:
          print('Invalid strategy. Please choose from the available options.');
      }
    }
  }
}

// =========================================================================
// CORE CLASSES (Demonstrating Inheritance)
// =========================================================================

/// [BASE CLASS - INHERITANCE]
/// A base class for any person in the game.
abstract class Person {
  String name;
  Person(this.name);

  void display();
}

/// Represents a single player, inheriting from Person.
class Player extends Person {
  String position;
  int id;
  int power;
  int stamina;

  Player(String name, this.position, this.id)
    : power = Random().nextInt(50) + 50,
      stamina = Random().nextInt(30) + 70,
      super(name);

  @override
  void display() {
    print(
      '    - Player ID: $id, Name: $name, Position: $position, Power: $power, Stamina: $stamina',
    );
  }
}

/// Represents a team trainer, inheriting from Person.
class Trainer extends Person {
  int experience;
  Strategy strategySpecialty;

  Trainer(String name)
    : experience = Random().nextInt(30) + 20,
      strategySpecialty =
          Strategy.values[Random().nextInt(Strategy.values.length)],
      super(name);

  @override
  void display() {
    print(
      '  > Trainer: $name, Experience: $experience, Specialty: ${strategySpecialty.name}',
    );
  }
}

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

/// Represents the stadium where the match is played
class Stadium {
  String name;
  String location;
  int capacity;
  WeatherCondition weather;

  Stadium(this.name, this.location, this.capacity)
    : weather = WeatherCondition
          .values[Random().nextInt(WeatherCondition.values.length)];

  void display() {
    print('🏟️  Welcome to $name in $location! 🏟️');
    print('   Capacity: $capacity fans');
    print('   Current Weather: ${weather.name}');
    print('============================================\n');
  }
}

// =========================================================================
// POWER MODIFIERS (Demonstrating Abstraction & Polymorphism)
// =========================================================================

/// [ABSTRACT CLASS - ABSTRACTION]
/// Defines the contract for any factor that can modify a team's power.
abstract class PowerModifier {
  String get name;
  int calculate(Team myTeam, Team opponentTeam, Stadium stadium);
}

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

/// Adds a random factor to the power calculation.
class RandomModifier extends PowerModifier {
  @override
  String get name => 'Random Factor';

  @override
  int calculate(Team myTeam, Team opponentTeam, Stadium stadium) {
    return Random().nextInt(25);
  }
}

// =========================================================================
// GAME SIMULATION
// =========================================================================

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

void main() {
  final game = Game();
  game.setup();
  game.simulate();
}
