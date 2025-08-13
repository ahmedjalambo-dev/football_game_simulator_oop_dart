# ⚽ Football Game Simulator (Dart, OOP)

A console-based **football (soccer) match simulator** written in Dart, showcasing **Object-Oriented Programming (OOP)** principles such as **Inheritance**, **Abstraction**, **Polymorphism**, and **Encapsulation**.

Players, trainers, teams, stadiums, and even the weather come together to create an unpredictable match outcome.  


## 📜 Features

- **Team creation**: Choose names, mascots, and add players with their positions.
- **Trainer system**: Trainers have random experience and strategic specialties.
- **Strategies**: Offensive, defensive, or balanced — each affects the match differently.
- **Weather system**: Sunny, rainy, or windy conditions influence gameplay.
- **Random factor**: Keeps matches exciting and unpredictable.
- **OOP Design**:
  - **Inheritance**: `Player` and `Trainer` inherit from `Person`.
  - **Abstraction**: `PowerModifier` defines the bonus calculation contract.
  - **Polymorphism**: Different modifiers (`StrategyModifier`, `WeatherModifier`, `RandomModifier`) are applied without knowing their exact type.
  - **Encapsulation**: Each class handles its own logic.


## 📂 Project Structure

```

lib/
main.dart                # Entry point
core/
enums.dart               # Enums for Strategy & WeatherCondition
input\_handler.dart      # Handles user input
models/
person.dart              # Base Person class
player.dart              # Player class
trainer.dart             # Trainer class
team.dart                # Team class
stadium.dart             # Stadium class
modifiers/
power\_modifier.dart     # Abstract PowerModifier
strategy\_modifier.dart  # Strategy-based bonus
weather\_modifier.dart   # Weather-based bonus
random\_modifier.dart    # Random bonus
game/
game.dart                # Game flow logic

````


## 🚀 Getting Started

### Prerequisites
- Install [Dart SDK](https://dart.dev/get-dart) (version >= 3.8.1)

### Install dependencies
```bash
dart pub get
````

### Run the game

```bash
dart run lib/main.dart
```


## 🛠 How It Works

1. **Setup Phase**:

   * Enter team names, mascots, and trainer names.
   * Assign player names and positions.
   * Choose a team strategy.
   * Create a stadium with name, location, and capacity.
   * Random weather condition is generated.

2. **Simulation Phase**:

   * Each team’s **base power** = sum of player power + trainer experience.
   * Power modifiers are applied:

     * **Strategy bonus** (based on both teams’ strategies)
     * **Weather bonus** (depends on stadium weather)
     * **Random factor** (adds unpredictability)
   * The team with the highest total power wins!


## 🎯 Example Gameplay

```
⚽ Welcome to the Football Game Simulator! ⚽

--- Setup Team 1 ---
Enter Team 1 Name: Falcons
Enter Team 1 Mascot: Hawk
Enter Trainer Name: Alex
Choose a team strategy (Offensive, Defensive, Balanced): Offensive
Enter number of players: 5
-- Player 1 --
  Name: John
  Position (e.g., Striker, Goalkeeper): Striker
...

🏟️  Welcome to National Stadium in Cityville! 🏟️
   Capacity: 50000 fans
   Current Weather: rainy
============================================

--- Power Analysis for Falcons ---
  Base Power (Players + Trainer): 380
  Strategy Bonus: 15
  Weather Bonus: 0
  Random Factor: 12
  --------------------------------
  TOTAL POWER: 407

🏆 FALCONS WINS THE MATCH! 🏆
```

