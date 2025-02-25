import 'dart:io';

void main() {
  while (true) {
    print('Enter first number:');
    double num1 = double.parse(stdin.readLineSync()!.trim());

    print('Enter an operator (+, -, *, /, %):');
    String operator = stdin.readLineSync()!;

    print('Enter second number:');
    double num2 = double.parse(stdin.readLineSync()!.trim());

    double result;

    switch (operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num1 / num2;
        break;
      case '%':
        result = num1 % num2;
        break;
      default:
        print('Invalid operator');
        continue;
    }

    print('Result: $result');

    print('Do you want to perform another calculation? (yes/no):');
    String? continueCalc = stdin.readLineSync();

    if (continueCalc != 'yes' || continueCalc != 'y') {
      break;
    }
  }
}