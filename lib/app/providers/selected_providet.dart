import 'dart:convert';
import 'package:book_store/app/utilites/character.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedProvider extends AsyncNotifier<List<Character>> {
  @override
  Future<List<Character>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedJson = prefs.getStringList('selected');
    if (selectedJson != null && selectedJson.isNotEmpty) {
      final loadedSelected = selectedJson.map((el) {
        final personMap = jsonDecode(el);
        return Character.fromJson(personMap);
      }).toList();
      return loadedSelected;
    }
    return [];
  }

  // Удаление персонажа
  Future<void> removePerson(Character person) async {
    final currentState = state.value ?? [];
    final updatedState = currentState.where((el) => el.id != person.id).toList();
    state = AsyncValue.data(updatedState); // Обновляем состояние
    await _savePerson(updatedState); // Сохраняем изменения в SharedPreferences
  }

  // Очистка списка
  Future<void> clean() async {
    state = const AsyncValue.data([]); // Обновляем состояние на пустой список
    await _savePerson([]); // Сохраняем пустой список
  }

  // Добавление персонажа
  Future<void> addPerson(Character person) async {
    final currentState = state.value ?? [];
    
    // Проверяем, есть ли персонаж в списке
    if (currentState.any((el) => el.id == person.id)) {
      return; // Если персонаж уже есть, ничего не делаем
    }
    
    // Если персонажа нет в списке, добавляем его
    final updatedState = [...currentState, person];
    state = AsyncValue.data(updatedState); // Обновляем состояние
    await _savePerson(updatedState); // Сохраняем изменения в SharedPreferences
  }

  // Сохранение списка персонажей в SharedPreferences
  Future<void> _savePerson(List<Character> list) async {
    final prefs = await SharedPreferences.getInstance();
    final selectedJson = list.map((el) => jsonEncode(el.toJson())).toList();
    await prefs.setStringList('selected', selectedJson); // Сохраняем список в SharedPreferences
  }
}

// Провайдер, который будет использоваться для работы с выбранными персонажами
final selectedProvider =
    AsyncNotifierProvider<SelectedProvider, List<Character>>(
        () => SelectedProvider());
