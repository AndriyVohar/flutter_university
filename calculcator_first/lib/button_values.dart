import 'package:flutter/material.dart';

enum Btn {
  del("D"),
  clr("C"),
  per("%"),
  multiply("×"),
  divide("÷"),
  add("+"),
  subtract("-"),
  calculate("="),
  dot("."),
  n0("0"),
  n1("1"),
  n2("2"),
  n3("3"),
  n4("4"),
  n5("5"),
  n6("6"),
  n7("7"),
  n8("8"),
  n9("9");

  final String value;

  const Btn(this.value);

  static const List<Btn> buttonValues = [
    Btn.del,
    Btn.clr,
    Btn.per,
    Btn.multiply,
    Btn.n7,
    Btn.n8,
    Btn.n9,
    Btn.divide,
    Btn.n4,
    Btn.n5,
    Btn.n6,
    Btn.subtract,
    Btn.n1,
    Btn.n2,
    Btn.n3,
    Btn.add,
    Btn.n0,
    Btn.dot,
    Btn.calculate,
  ];

  static Color? getButtonColor(Btn btn) {
    if ([Btn.del, Btn.clr].contains(btn)) {
      return Colors.blueGrey;
    } else if ([
      Btn.per,
      Btn.multiply,
      Btn.add,
      Btn.subtract,
      Btn.divide,
      Btn.calculate,
    ].contains(btn)) {
      return Colors.orange;
    }

    return Colors.grey[850];
  }
}
