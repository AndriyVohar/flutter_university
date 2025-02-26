/**
 * 1. Дано одновимірний масив дійсних чисел.
 * Знайти найбільший елемент серед від’ємних елементів цього масиву.
 */


import 'dart:io';

void main() {
  print('Enter a list separated by spaces (example: 1 2 3):');
  final String provided = stdin.readLineSync()!.trim();

  final List<int> list = provided.split(',').map(int.parse).toList();
  print('List: $list');

  final int? maxFromNegative = list.fold<int?>(
      null,
          (int? max, int element) =>
      element < 0 && (max == null || element > max) ? element : max
  );
  print('Max from negative: $maxFromNegative');
}