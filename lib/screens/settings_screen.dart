import 'package:alarmle/viewmodels/settings_view_model.dart';
import 'package:alarmle/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

const _wordleGreen = Color(0xFF57AC57);
const _wordleYellow = Color(0xFFC8B652);
const _wordleDarkBg = Color(0xFF333333);
const _wordleSurface = Color(0xFF1C1C1E);
const _wordleTextSecondary = Color(0xFF8E8E93);
const _wordleBorder = Color(0xFF3A3A3C);

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _locales = [
    Locale('es'),
    Locale('en'),
    Locale('pt'),
    Locale('fr'),
    Locale('zh'),
  ];

  static const _localeLabels = {
    'es': 'Español',
    'en': 'Inglés',
    'pt': 'Portugués',
    'fr': 'Francés',
    'zh': 'Mandarín',
  };

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SettingsViewModel>();
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: _wordleDarkBg,
      appBar: AppBar(
        backgroundColor: _wordleSurface,
        title: Text(l10n.settingsTitle),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator(color: _wordleGreen))
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              children: [
                // ─── Minutos de snooze ───
                _SectionLabel(l10n.snoozeLabel),
                const SizedBox(height: 4),
                Text(
                  '${vm.defaultSnoozeMinutes} min',
                  style: const TextStyle(color: _wordleTextSecondary, fontSize: 14),
                ),
                Slider(
                  value: vm.defaultSnoozeMinutes.toDouble(),
                  min: 1,
                  max: 30,
                  divisions: 29,
                  activeColor: _wordleGreen,
                  inactiveColor: _wordleBorder,
                  label: '${vm.defaultSnoozeMinutes} min',
                  onChanged: (value) => vm.updateSnoozeMinutes(value.round()),
                ),
                const SizedBox(height: 24),

                // ─── Volumen ───
                _SectionLabel(l10n.volumeLabel),
                const SizedBox(height: 4),
                Text(
                  '${(vm.appVolume * 100).round()}%',
                  style: const TextStyle(color: _wordleTextSecondary, fontSize: 14),
                ),
                Slider(
                  value: vm.appVolume,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  activeColor: _wordleYellow,
                  inactiveColor: _wordleBorder,
                  label: '${(vm.appVolume * 100).round()}%',
                  onChanged: (value) => vm.updateVolume(value),
                ),
                const SizedBox(height: 32),

                // ─── Idioma ───
                _SectionLabel(l10n.languageLabel),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: _wordleSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _wordleBorder),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Locale>(
                      value: vm.currentLocale ?? _locales.first,
                      dropdownColor: _wordleSurface,
                      icon: const Icon(Icons.arrow_drop_down, color: _wordleGreen),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      items: _locales
                          .map((l) => DropdownMenuItem(
                                value: l,
                                child: Text(_localeLabels[l.languageCode] ?? l.languageCode),
                              ))
                          .toList(),
                      onChanged: (locale) {
                        if (locale != null) {
                          context.read<SettingsViewModel>().changeLocale(locale);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}