import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:book_keep/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../data/repositories/settings_repository.dart';

final settingsRepositoryProvider = Provider((ref) => SettingsRepository());

class SettingsState {
  final ThemeMode themeMode;
  final Locale? locale;
  final bool isLoading;
  final String? error;

  const SettingsState({
    required this.themeMode,
    this.locale,
    this.isLoading = false,
    this.error,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    Object? locale = _unsetLocale,
    bool? isLoading,
    String? error,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale == _unsetLocale ? this.locale : locale as Locale?,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

const _unsetLocale = Object();

// Persists lightweight settings such as theme mode and locale preference.
class SettingsNotifier extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    _loadSettings();
    return const SettingsState(themeMode: ThemeMode.system, isLoading: true);
  }

  Future<void> _loadSettings() async {
    final repo = ref.read(settingsRepositoryProvider);
    try {
      final themeValue = await repo.getThemeMode();
      final localeCode = await repo.getLocaleCode();
      final mode = _parseThemeMode(themeValue);
      final locale = _parseLocale(localeCode);
      if (locale != null) {
        Intl.defaultLocale = _localeToCode(locale);
      }
      state = state.copyWith(themeMode: mode, locale: locale, isLoading: false, error: null);
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

  Future<void> updateLocale(Locale? locale) async {
    final repo = ref.read(settingsRepositoryProvider);
    try {
      final resolved = _resolveSupportedLocale(locale);
      if (resolved != null) {
        Intl.defaultLocale = _localeToCode(resolved);
      } else {
        Intl.defaultLocale = null;
      }
      await repo.setLocaleCode(resolved == null ? null : _localeToCode(resolved));
      state = state.copyWith(locale: resolved, error: null);
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

  Locale? _parseLocale(String? code) {
    if (code == null || code.isEmpty) return null;
    final tag = code.replaceAll('_', '-');
    final parts = tag.split('-');
    final language = parts.isNotEmpty ? parts[0] : 'en';
    String? script;
    String? country;

    if (parts.length >= 2) {
      if (parts[1].length == 4) {
        script = parts[1];
        if (parts.length >= 3) {
          country = parts[2];
        }
      } else {
        country = parts[1];
      }
    }

    final parsed = Locale.fromSubtags(languageCode: language, scriptCode: script, countryCode: country);
    return _resolveSupportedLocale(parsed);
  }

  Locale? _resolveSupportedLocale(Locale? locale) {
    if (locale == null) return null;

    for (final supported in AppLocalizations.supportedLocales) {
      final matchesLanguage = supported.languageCode == locale.languageCode;
      final matchesScript = supported.scriptCode == locale.scriptCode || supported.scriptCode == null || locale.scriptCode == null;
      final matchesCountry = supported.countryCode == locale.countryCode || supported.countryCode == null || locale.countryCode == null;
      if (matchesLanguage && matchesScript && matchesCountry) {
        return supported;
      }
    }

    // Fallback to English when no direct match is found.
    return const Locale('en');
  }

  String _localeToCode(Locale locale) {
    if (locale.scriptCode != null && (locale.countryCode?.isNotEmpty ?? false)) {
      return '${locale.languageCode}-${locale.scriptCode}-${locale.countryCode}';
    }
    if (locale.scriptCode != null) {
      return '${locale.languageCode}-${locale.scriptCode}';
    }
    if (locale.countryCode != null && locale.countryCode!.isNotEmpty) {
      return '${locale.languageCode}-${locale.countryCode}';
    }
    return locale.languageCode;
  }
}

final settingsNotifierProvider = NotifierProvider<SettingsNotifier, SettingsState>(
  () => SettingsNotifier(),
);
