import 'package:alarmle/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF333333),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.aboutLabel,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Logo de la app
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _LogoBlock('A', const Color(0xFF57AC57)),
                _LogoBlock('L', const Color(0xFFC8B652)),
                _LogoBlock('A', const Color(0xFF939393)),
                _LogoBlock('R', const Color(0xFF57AC57)),
                _LogoBlock('M', const Color(0xFFC8B652)),
                _LogoBlock('L', const Color(0xFF939393)),
                _LogoBlock('E', const Color(0xFF57AC57)),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Alarmle',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.version,
              style: const TextStyle(
                color: Color(0xFF8E8E93),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 48),
            // Descripción
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF3A3A3C)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: const Color(0xFF57AC57), size: 20),
                      const SizedBox(width: 8),
                      Text(
                        l10n.aboutTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.aboutDescription,
                    style: TextStyle(
                      color: const Color(0xFF8E8E93),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Características
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF3A3A3C)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star_outline, color: const Color(0xFFC8B652), size: 20),
                      const SizedBox(width: 8),
                      Text(
                        l10n.featuresTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _FeatureItem(
                    icon: Icons.alarm,
                    title: l10n.customAlarms,
                    description: l10n.customAlarmsDesc,
                  ),
                  const SizedBox(height: 12),
                  _FeatureItem(
                    icon: Icons.emoji_events_outlined,
                    title: l10n.wordleGame,
                    description: l10n.wordleGameDesc,
                  ),
                  const SizedBox(height: 12),
                  _FeatureItem(
                    icon: Icons.sync_outlined,
                    title: l10n.cloudSync,
                    description: l10n.cloudSyncDesc,
                  ),
                  const SizedBox(height: 12),
                  _FeatureItem(
                    icon: Icons.public,
                    title: l10n.multiLanguage,
                    description: l10n.multiLanguageDesc,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Tecnologías
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF3A3A3C)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.code_outlined, color: const Color(0xFF57AC57), size: 20),
                      const SizedBox(width: 8),
                      Text(
                        l10n.technologiesTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _TechChip('Flutter'),
                      _TechChip('Firebase'),
                      _TechChip('Dart'),
                      _TechChip('Provider'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Copyright
            Text(
              l10n.copyright,
              style: TextStyle(
                color: const Color(0xFF636366),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoBlock extends StatelessWidget {
  final String letter;
  final Color color;

  const _LogoBlock(this.letter, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF57AC57), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  color: const Color(0xFF8E8E93),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;

  const _TechChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF57AC57).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF57AC57).withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF57AC57),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}