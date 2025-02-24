import 'package:flutter/material.dart';
import 'button_values.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = '';
  String operand = '';
  String number2 = '';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SingleChildScrollView(
              reverse: true,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(16),
                child: Text(
                  "$number1 $operand $number2".isNotEmpty
                      ? "$number1 $operand $number2"
                      : "0",
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),

            // buttons
            Wrap(
              children:
                  Btn.buttonValues
                      .map(
                        (Btn btn) => SizedBox(
                          width:
                              btn == Btn.n0
                                  ? screenSize.width / 2
                                  : screenSize.width / 4,
                          height: screenSize.width / 5,
                          child: buildButton(btn),
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(Btn btn) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Material(
        color: Btn.getButtonColor(btn),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: Colors.white24, width: 1),
        ),
        child: InkWell(
          onTap: () => onBtnTap(btn),
          child: Center(
            child: Text(
              btn.value,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  void onBtnTap(Btn btn) {
    if (btn == Btn.clr) {
      number1 = '';
      operand = '';
      number2 = '';
    } else if (btn == Btn.del) {
      if (number2.isNotEmpty) {
        number2 = number2.substring(0, number2.length - 1);
      } else if (operand.isNotEmpty) {
        operand = '';
      } else if (number1.isNotEmpty) {
        number1 = number1.substring(0, number1.length - 1);
      }
    } else if (btn == Btn.calculate) {
      if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
        final double num1 = double.parse(number1);
        final double num2 = double.parse(number2);
        double result = 0;

        switch (operand) {
          case '+':
            result = num1 + num2;
            break;
          case '-':
            result = num1 - num2;
            break;
          case '×':
            result = num1 * num2;
            break;
          case '÷':
            result = num1 / num2;
            break;
          case '%':
            result = num1 % num2;
            break;
        }

        number1 = result.toString();
        operand = '';
        number2 = '';
      }
    } else if (btn == Btn.add ||
        btn == Btn.subtract ||
        btn == Btn.multiply ||
        btn == Btn.divide ||
        btn == Btn.per) {
      if (number1.isNotEmpty && operand.isEmpty) {
        operand = btn.value;
      }
    } else {
      if (operand.isEmpty) {
        number1 += btn.value;
      } else {
        number2 += btn.value;
      }
    }

    setState(() {});
  }
}
