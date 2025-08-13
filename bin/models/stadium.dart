import 'dart:math';

import '../core/enums.dart';

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
