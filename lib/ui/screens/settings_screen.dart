import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/localization_ext.dart';
import '../../state/settings_provider.dart';
import 'categories_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final settings = ref.watch(settingsNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.appearanceTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                RadioListTile<ThemeMode>(
                  value: ThemeMode.system,
                  groupValue: settings.themeMode,
                  onChanged: (value) => ref.read(settingsNotifierProvider.notifier).updateThemeMode(value!),
                  title: Text(l10n.themeSystem),
                ),
                const Divider(height: 1),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.light,
                  groupValue: settings.themeMode,
                  onChanged: (value) => ref.read(settingsNotifierProvider.notifier).updateThemeMode(value!),
                  title: Text(l10n.themeLight),
                ),
                const Divider(height: 1),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.dark,
                  groupValue: settings.themeMode,
                  onChanged: (value) => ref.read(settingsNotifierProvider.notifier).updateThemeMode(value!),
                  title: Text(l10n.themeDark),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(l10n.languageTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Card(
            child: Builder(builder: (context) {
              final options = _languageOptions(context);
              return Column(
                children: options.asMap().entries.map((entry) {
                  final option = entry.value;
                  final locale = option.$1;
                  final label = option.$2;
                  final groupValue = settings.locale;
                  final isLast = entry.key == options.length - 1;
                  return Column(
                    children: [
                      RadioListTile<Locale?>(
                        value: locale,
                        groupValue: groupValue,
                        onChanged: (value) => ref.read(settingsNotifierProvider.notifier).updateLocale(value),
                        title: Text(label),
                      ),
                      if (!isLast) const Divider(height: 1),
                    ],
                  );
                }).toList(),
              );
            }),
          ),
          const SizedBox(height: 24),
          Text(l10n.categoriesSectionTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.category),
              title: Text(l10n.manageCategoriesTitle),
              subtitle: Text(l10n.manageCategoriesSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoriesScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<(Locale?, String)> _languageOptions(BuildContext context) {
    final l10n = context.l10n;
    return [
      (null, l10n.languageSystem),
      (const Locale('en'), l10n.languageEnglish),
      (const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'), l10n.languageChineseSimplified),
      (const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'), l10n.languageChineseTraditional),
      (const Locale('ja'), l10n.languageJapanese),
      (const Locale('ko'), l10n.languageKorean),
      (const Locale('es'), l10n.languageSpanish),
      (const Locale('fr'), l10n.languageFrench),
      (const Locale('de'), l10n.languageGerman),
      (const Locale('pt', 'BR'), l10n.languagePortuguese),
      (const Locale('ru'), l10n.languageRussian),
    ];
  }
}
