import 'dart:io';
import 'dart:math';

void main() {
  print("Write the count of elements in list:");
  int count = int.parse(stdin.readLineSync()!.trim());

  List<int> list = generateRandomList(count);
  print("List is: ${list.join(', ')}");

  int positiveCount = getPositiveCount(list);
  print("Count of positive numbers: $positiveCount");
}

List<int> generateRandomList(int count) {
  List<int> list = [];
  Random random = Random();
  for (int i = 0; i < count; i++) {
    list.add(random.nextInt(200) - 100);
  }
  return list;
}

int getPositiveCount(List<int> list) {
  // return list.where((int element) => element > 0).length;
  return list.fold(0, (int sum, int element) => element > 0 ? sum + 1 : sum);
}
