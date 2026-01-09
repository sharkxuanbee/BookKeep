import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/settings_repository.dart';

final settingsRepositoryProvider = Provider((ref) => SettingsRepository());

class SettingsState {
  final ThemeMode themeMode;
  final bool isLoading;
  final String? error;

  const SettingsState({
    required this.themeMode,
    this.isLoading = false,
    this.error,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    bool? isLoading,
    String? error,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Persists lightweight settings such as theme mode.
class SettingsNotifier extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    _loadSettings();
    return const SettingsState(themeMode: ThemeMode.system, isLoading: true);
  }

  Future<void> _loadSettings() async {
    final repo = ref.read(settingsRepositoryProvider);
    try {
      final value = await repo.getThemeMode();
      final mode = _parseThemeMode(value);
      state = state.copyWith(themeMode: mode, isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    final repo = ref.read(settingsRepositoryProvider);
    try {
      await repo.setThemeMode(_themeModeToString(mode));
      state = state.copyWith(themeMode: mode, error: null);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  ThemeMode _parseThemeMode(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}

final settingsNotifierProvider = NotifierProvider<SettingsNotifier, SettingsState>(
  () => SettingsNotifier(),
);
