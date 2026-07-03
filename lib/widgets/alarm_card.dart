import 'package:alarmle/models/alarm_model.dart';
import 'package:alarmle/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

const _wordleGreen = Color(0xFF57AC57);
const _wordleSurface = Color(0xFF1C1C1E);
const _wordleBorder = Color(0xFF3A3A3C);

class AlarmCard extends StatelessWidget {
  final Alarm alarm;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDelete;
  final bool selectionMode;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const AlarmCard({
    super.key,
    required this.alarm,
    required this.onToggle,
    required this.onDelete,
    this.selectionMode = false,
    this.isSelected = false,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final timeColor = alarm.isEnabled
        ? Colors.white
        : const Color(0xFF636366);

    final subtitleColor = alarm.isEnabled
        ? const Color(0xFF8E8E93)
        : const Color(0xFF48484A);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2C2C2E)
              : _wordleSurface,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: _wordleGreen, width: 1.5)
              : Border.all(color: _wordleBorder, width: 0.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        alarm.formattedTime,
                        style: TextStyle(
                          color: timeColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                          letterSpacing: -1,
                          height: 1,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        alarm.period(l10n),
                        style: TextStyle(
                          color: subtitleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (alarm.title.isNotEmpty)
                    Text(
                      alarm.title,
                      style: TextStyle(
                        color: timeColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.repeat, size: 13, color: subtitleColor),
                      const SizedBox(width: 4),
                      Text(
                        alarm.repeatLabel(l10n),
                        style: TextStyle(color: subtitleColor, fontSize: 13),
                      ),
                      if (alarm.vibrate) ...[
                        const SizedBox(width: 12),
                        Icon(Icons.vibration, size: 13, color: subtitleColor),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            if (selectionMode)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: isSelected
                    ? Container(
                        key: const ValueKey('checked'),
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: _wordleGreen,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 18),
                      )
                    : Container(
                        key: const ValueKey('unchecked'),
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: _wordleBorder, width: 1.5),
                        ),
                      ),
              )
            else
              Switch(
                value: alarm.isEnabled,
                onChanged: onToggle,
                activeTrackColor: _wordleGreen,
                activeThumbColor: Colors.white,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: const Color(0xFF3A3A3C),
              ),
          ],
        ),
      ),
    );
  }
}