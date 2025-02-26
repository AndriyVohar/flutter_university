// клас для опрацювання списку. може передатися готовий, може передатися стрінга (1, 2, 3)
// або передається число, і тоді рандомно робиться список
// додати методи для знаходження мінімального, максимального, середнього значення

import 'dart:io';
import 'dart:math';

class ListHandler {
  List<int> list = [];

  ListHandler(dynamic input) {
    if (input is int) {
      ListHandler.fromInt(input);
    } else if (input is String) {
      ListHandler.fromString(input);
    } else {
      Exception('Invalid input');
    }
  }

  ListHandler.fromString(String input) {
    list = input.split(', ').map((String element) => int.parse(element)).toList();
  }

  ListHandler.fromInt(int count) {
    list = generateRandomList(count);
  }

  static generateRandomList(int count) {
    List<int> list = [];
    Random random = Random();
    for (int i = 0; i < count; i++) {
      list.add(random.nextInt(200) - 100);
    }
    return list;
  }

  int getMaxValue() {
    return list.reduce(max);
  }

  int getMinValue() {
    return list.reduce(min);
  }

  int getAverageValue() {
    return list.reduce((int sum, int element) => sum + element) ~/ list.length;
  }

  @override
  String toString() {
    return list.join(', ');
  }
}


void main() {
  print('Enter a list of numbers separated by commas:');
  ListHandler listHandler = new ListHandler(stdin.readLineSync()!.trim());

  print("List: $listHandler");

  print("Max value: ${listHandler.getMaxValue()}");
  print("Min value: ${listHandler.getMinValue()}");
  print("Average value: ${listHandler.getAverageValue()}");
}
