import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:book_keep/l10n/app_localizations.dart';

import 'core/theme/app_theme.dart';
import 'state/settings_provider.dart';
import 'ui/screens/app_shell.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: settings.themeMode,
      locale: settings.locale,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      localeListResolutionCallback: (locales, supported) {
        if (settings.locale != null) return settings.locale;
        if (locales != null) {
          for (final locale in locales) {
            for (final supportedLocale in supported) {
              final matchesLanguage = locale.languageCode == supportedLocale.languageCode;
              final matchesScript = locale.scriptCode == null || supportedLocale.scriptCode == null || locale.scriptCode == supportedLocale.scriptCode;
              if (matchesLanguage && matchesScript) {
                return supportedLocale;
              }
            }
          }
        }
        return const Locale('en');
      },
      home: const AppShell(),
    );
  }
}
