import 'package:alarmle/models/alarm_model.dart';
import 'package:flutter/material.dart';


class AlarmCard extends StatelessWidget 
{
  final Alarm alarm;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDelete;
  final bool selectionMode;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const AlarmCard
  ({
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
  Widget build(BuildContext context) 
  {
    final timeColor = alarm.isEnabled && !selectionMode
        ? Colors.white
        : alarm.isEnabled
            ? Colors.white
            : const Color(0xFF636366);
            
    final subtitleColor = alarm.isEnabled 
      ? const Color(0xFF8E8E93) 
      : const Color(0xFF48484A);

    return GestureDetector
    (
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer
      (
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration
        (
          color: isSelected
              ? const Color(0xFF2C2C2E)
              : const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: const Color(0xFF0A84FF), width: 1.5)
              : null,
        ),
        child: Row
        (
          children: 
          [
            // Contenido principal
            Expanded
            (
              child: Column
              (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: 
                [
                  Row
                  (
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: 
                    [
                      Text
                      (
                        alarm.formattedTime,
                        style: TextStyle
                        (
                          color: timeColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                          letterSpacing: -1,
                          height: 1,
                        ),
                      ),
                      const SizedBox(width: 6),

                      Text
                      (
                        alarm.period,
                        style: TextStyle
                        (
                          color: subtitleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  if (alarm.title.isNotEmpty)
                    Text
                    (
                      alarm.title,
                      style: TextStyle
                      (
                        color: timeColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 4),

                  Row
                  (
                    children: 
                    [
                      Icon(Icons.repeat, size: 13, color: subtitleColor),
                      const SizedBox(width: 4),
                      Text
                      (
                        alarm.repeatLabel,
                        style: TextStyle(color: subtitleColor, fontSize: 13),
                      ),
                      if (alarm.vibrate) ...
                      [
                        const SizedBox(width: 12),
                        Icon(Icons.vibration, size: 13, color: subtitleColor),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Trailing: toggle normal o checkbox en selección
            if (selectionMode)
            AnimatedSwitcher
            (
              duration: const Duration(milliseconds: 150),
              child: isSelected
              ? Container
              (
                key: const ValueKey('checked'),
                width: 26,
                height: 26,
                decoration: BoxDecoration
                (
                  color: const Color(0xFF0A84FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.check,
                    color: Colors.white, size: 18),
              )
              : Container
              (
                key: const ValueKey('unchecked'),
                width: 26,
                height: 26,
                decoration: BoxDecoration
                (
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all
                  (color: const Color(0xFF636366), width: 1.5),
                ),
              ),
            )

            else
              Switch
              (
                value: alarm.isEnabled,
                onChanged: onToggle,
                activeColor: Colors.white,
                activeTrackColor: const Color(0xFF0A84FF),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: const Color(0xFF3A3A3C),
              ),
          ],
        ),
      ),
    );
  }
}