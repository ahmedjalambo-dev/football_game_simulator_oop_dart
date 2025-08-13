import 'dart:io';
import 'enums.dart';

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
