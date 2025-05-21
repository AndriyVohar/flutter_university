import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class AppState {
  final List dormitoryList;
  final String selectedDormitoryId;

  AppState({
    this.dormitoryList = const [],
    this.selectedDormitoryId = '2',
  });

  AppState copyWith({
    List? dormitoryList,
    String? selectedDormitoryId,
  }) {
    return AppState(
      dormitoryList: dormitoryList ?? this.dormitoryList,
      selectedDormitoryId: selectedDormitoryId ?? this.selectedDormitoryId,
    );
  }
}

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier() : super(AppState());

  Future<void> setDormitoryList(List val) async {
    state = state.copyWith(
      dormitoryList: val,
      selectedDormitoryId:
      state.selectedDormitoryId == '0'
          ? val.first['id']
          : state.selectedDormitoryId,
    );
  }

  Future<void> fetchDormitoryList() async {
    try {
      final uri = Uri.parse('https://api-studmistechko.uzhnu.edu.ua/api/dormitories');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data is Map<String, dynamic> && data.containsKey('data')) {
           data = data['data'] as List;
        }

        setDormitoryList(data);
      }
    } catch (e) {
      //
    }
  }

  Future<void> setSelectedDormitoryId(String val) async {
    state = state.copyWith(selectedDormitoryId: val);
  }
}

final appProvider = StateNotifierProvider<AppNotifier, AppState>(
      (ref) => AppNotifier(),
);