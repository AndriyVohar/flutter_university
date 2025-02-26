/**
 * 2. Знайти найбільший елемент квадратної матриці,
 * який знаходиться вище головної діагоналі.
 */


import 'dart:io';

void main() {
  print('Enter the size of the matrix (n for an n x n matrix):');
  final int n = int.parse(stdin.readLineSync()!.trim());

  print('Enter the matrix elements row by row, separated by spaces (example: 1 2 3 4):');
  List<List<int>> matrix = [];
  for (int i = 0; i < n; i++) {
    matrix.add(stdin.readLineSync()!.trim().split(' ').map(int.parse).toList());
  }

  int? maxAboveDiagonal;
  for (int i = 0; i < n; i++) {
    for (int j = i + 1; j < n; j++) {
      if (maxAboveDiagonal == null || matrix[i][j] > maxAboveDiagonal) {
        maxAboveDiagonal = matrix[i][j];
      }
    }
  }

  print('Max element above the main diagonal: $maxAboveDiagonal');
}