/**
 * Описати клас, який містить вказані поля і методи.
 * Клас “Трикутник” – TTriangle
 * Поля:
 *   • для зберігання довжин сторін;
 * Методи:
 *   • конструктор без параметрів, конструктор з параметрами, конструктор копіювання;
 *   • введення/виведення даних;
 *   • визначення площі;
 *   • визначення периметру;
 *   • порівняння з іншим трикутником;
 *   • перевантаження операторів + (додавання довжин сторін), – (віднімання довжин відповідних сторін), * (множення сторін на деяке число).
 */


import 'dart:io';
import 'dart:math';

void main() {
  Triangle t1 = Triangle(3, 4, 5);
  Triangle t2 = Triangle(6, 8, 10);
  Triangle t3 = Triangle.empty();
  Triangle t4 = Triangle.copy(t1);

  print('Area of t1: ${t1.getArea()}');
  print('Perimeter of t1: ${t1.getPerimeter()}');

  print('Comparison of t1 and t2: ${t1.compare(t2)}');

  Triangle t5 = t1 + 2;
  print('t1 + 2: (${t5.a}, ${t5.b}, ${t5.c})');

  Triangle t6 = t1 - 2;
  print('t1 - 2: (${t6.a}, ${t6.b}, ${t6.c})');

  Triangle t7 = t1 * 2;
  print('t1 * 2: (${t7.a}, ${t7.b}, ${t7.c})');
}

class Triangle {
  final double a;
  final double b;
  final double c;

  Triangle(this.a, this.b, this.c);
  Triangle.empty() : a = 1, b = 1, c = 1;
  Triangle.copy(Triangle other)
      : a = other.a,
        b = other.b,
        c = other.c;

  double getArea() {
    final double p = (a + b + c) / 2;
    return sqrt(p * (p - a) * (p - b) * (p - c));
  }

  double getPerimeter() => a + b + c;

  String compare(Triangle other) {
    final double thisArea = getArea();
    final double otherArea = other.getArea();
    final double thisPerimeter = getPerimeter();
    final double otherPerimeter = other.getPerimeter();

    if (thisArea > otherArea) {
      return 'This triangle has a larger area.';
    } else if (thisArea < otherArea) {
      return 'The other triangle has a larger area.';
    } else {
      if (thisPerimeter > otherPerimeter) {
        return 'This triangle has a larger perimeter.';
      } else if (thisPerimeter < otherPerimeter) {
        return 'The other triangle has a larger perimeter.';
      } else {
        return 'Both triangles are equal in area and perimeter.';
      }
    }
  }

  Triangle operator +(double value) {
    return Triangle(a + value, b + value, c + value);
  }
  Triangle operator -(double value) {
    return Triangle(a - value, b - value, c - value);
  }
  Triangle operator *(double multiplier) {
    return Triangle(a * multiplier, b * multiplier, c * multiplier);
  }

  @override
  String toString() {
    return 'Triangle: a = $a, b = $b, c = $c';
  }
}