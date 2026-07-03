import 'package:alarmle/models/alarm_model.dart';
import 'package:alarmle/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

const _wordleGreen = Color(0xFF57AC57);
const _wordleSurfaceLight = Color(0xFF2C2C2E);
const _wordleTextPrimary = Colors.white;
const _wordleTextSecondary = Color(0xFF8E8E93);
const _wordleBorder = Color(0xFF3A3A3C);
const _loopMultiplier = 1000;

class EditAlarmSheet extends StatefulWidget {
  final Alarm alarm;
  final Function(Alarm) onAlarmEdited;

  const EditAlarmSheet({
    super.key,
    required this.alarm,
    required this.onAlarmEdited,
  });

  @override
  State<EditAlarmSheet> createState() => _EditAlarmSheetState();
}

class _EditAlarmSheetState extends State<EditAlarmSheet> {
  late TextEditingController _titleController;
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _periodController;

  late int _hour;
  late int _minute;
  late bool _isPM;
  late bool _repeatOnce;
  late List<bool> _repeatDays;
  late bool _vibrate;

  @override
  void initState() {
    super.initState();

    final a = widget.alarm;
    _isPM = a.hour >= 12;
    _hour = a.hour % 12 == 0 ? 12 : a.hour % 12;
    _minute = a.minute;

    final anyDay = a.repeatDays.any((d) => d);
    _repeatOnce = !anyDay;
    _repeatDays = List<bool>.from(a.repeatDays);
    _vibrate = a.vibrate;

    _titleController = TextEditingController(text: a.title);

    _hourController = FixedExtentScrollController(
      initialItem: _loopMultiplier * 12 + (_hour - 1),
    );
    _minuteController = FixedExtentScrollController(
      initialItem: _loopMultiplier * 60 + _minute,
    );
    _periodController = FixedExtentScrollController(
      initialItem: _isPM ? 1 : 0,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  String _nextAlarmPreview(AppLocalizations l10n) {
    final now = DateTime.now();
    final int hour24 = _isPM
        ? (_hour == 12 ? 12 : _hour + 12)
        : (_hour == 12 ? 0 : _hour);

    DateTime? trigger;

    if (_repeatOnce) {
      final today = DateTime(now.year, now.month, now.day, hour24, _minute);
      trigger = today.isAfter(now) ? today : today.add(const Duration(days: 1));
    } else {
      final anySelected = _repeatDays.any((d) => d);
      if (!anySelected) return l10n.selectAtLeastOneDay;

      for (int offset = 0; offset < 7; offset++) {
        final candidate = DateTime(
          now.year, now.month, now.day, hour24, _minute,
        ).add(Duration(days: offset));
        final dayIndex = candidate.weekday - 1;
        if (_repeatDays[dayIndex] && candidate.isAfter(now)) {
          trigger = candidate;
          break;
        }
      }
      trigger ??= DateTime(now.year, now.month, now.day, hour24, _minute)
          .add(const Duration(days: 7));
    }

    final diff = trigger.difference(now);
    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final mins = diff.inMinutes % 60;

    if (days >= 1) {
      if (hours > 0) {
        return l10n.nextAlarmIn("$days d ${hours}h ${mins}min");
      }
      return l10n.nextAlarmIn("$days d ${mins}min");
    }
    if (hours > 0) return l10n.nextAlarmIn("${hours}h ${mins}min");
    return l10n.nextAlarmIn("$mins min");
  }

  void _submit() {
    final int hour24 = _isPM
        ? (_hour == 12 ? 12 : _hour + 12)
        : (_hour == 12 ? 0 : _hour);

    final days = _repeatOnce
        ? List.filled(7, false)
        : List<bool>.from(_repeatDays);

    widget.onAlarmEdited(Alarm(
      id: widget.alarm.id,
      title: _titleController.text.trim(),
      hour: hour24,
      minute: _minute,
      repeatDays: days,
      vibrate: _vibrate,
      snoozeMinutes: widget.alarm.snoozeMinutes,
      snoozeCount: widget.alarm.snoozeCount,
      isEnabled: widget.alarm.isEnabled,
    ));

    Navigator.pop(context);
  }

  Widget _buildDrumPicker(AppLocalizations l10n) {
    return SizedBox(
      height: 160,
      child: Row(
        children: [
          Expanded(
            child: _buildLoopScroller(
              controller: _hourController,
              itemCount: 12,
              label: (i) => (i + 1).toString(),
              onChanged: (i) => setState(() => _hour = (i % 12) + 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              ':',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w200,
                color: _wordleTextPrimary,
              ),
            ),
          ),
          Expanded(
            child: _buildLoopScroller(
              controller: _minuteController,
              itemCount: 60,
              label: (i) => (i % 60).toString().padLeft(2, '0'),
              onChanged: (i) => setState(() => _minute = i % 60),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 72,
            child: ListWheelScrollView(
              controller: _periodController,
              itemExtent: 52,
              diameterRatio: 1.4,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (i) => setState(() => _isPM = i == 1),
              children: [l10n.amLabel, l10n.pmLabel].map((label) {
                return Center(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: _wordleTextPrimary,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoopScroller({
    required FixedExtentScrollController controller,
    required int itemCount,
    required String Function(int) label,
    required Function(int) onChanged,
  }) {
    final totalItems = itemCount * _loopMultiplier * 2;
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: 52,
      diameterRatio: 1.4,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: onChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: totalItems,
        builder: (context, index) => Center(
          child: Text(
            label(index % itemCount),
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w200,
              color: _wordleTextPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRepeatSection(AppLocalizations l10n) {
    final dayLabels = [
      l10n.monShort, l10n.tueShort, l10n.wedShort, l10n.thuShort,
      l10n.friShort, l10n.satShort, l10n.sunShort,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRepeatChip(
                label: l10n.onceLabel,
                selected: _repeatOnce,
                onTap: () => setState(() => _repeatOnce = true),
              ),
              const SizedBox(width: 10),
              _buildRepeatChip(
                label: l10n.customizeLabel,
                selected: !_repeatOnce,
                onTap: () => setState(() => _repeatOnce = false),
              ),
            ],
          ),
        ),
        if (!_repeatOnce) ...[
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final selected = _repeatDays[i];
              return GestureDetector(
                onTap: () => setState(() => _repeatDays[i] = !selected),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? _wordleGreen : _wordleSurfaceLight,
                    border: selected
                        ? null
                        : Border.all(color: _wordleBorder),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    dayLabels[i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          selected ? Colors.white : _wordleTextSecondary,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }

  Widget _buildRepeatChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? _wordleGreen : _wordleSurfaceLight,
          borderRadius: BorderRadius.circular(20),
          border: selected ? null : Border.all(color: _wordleBorder),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : _wordleTextSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildOptionRow({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        child: Row(
          children: [
            Icon(icon, color: _wordleTextSecondary, size: 20),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: _wordleTextPrimary, fontSize: 15)),
                  if (subtitle != null)
                    Text(subtitle,
                        style: const TextStyle(
                            color: _wordleTextSecondary, fontSize: 13)),
                ],
              ),
            ),
            trailing ??
                const Icon(Icons.chevron_right,
                    color: _wordleTextSecondary, size: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: _wordleBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(l10n.cancel,
                        style: const TextStyle(
                            color: _wordleGreen, fontSize: 16)),
                  ),
                  Text(
                    l10n.editAlarm,
                    style: const TextStyle(
                      color: _wordleTextPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: _submit,
                    child: Text(
                      l10n.done,
                      style: const TextStyle(
                          color: _wordleGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  _nextAlarmPreview(l10n),
                  style: const TextStyle(
                      color: _wordleTextSecondary, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDrumPicker(l10n),
          const SizedBox(height: 24),
          _buildRepeatSection(l10n),
          const SizedBox(height: 20),
          TextField(
            controller: _titleController,
            style: const TextStyle(color: _wordleTextPrimary),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: l10n.alarmName,
              hintStyle: const TextStyle(color: _wordleTextSecondary),
              prefixIcon: const Icon(Icons.label_outline,
                  color: _wordleTextSecondary),
              filled: true,
              fillColor: _wordleSurfaceLight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: _wordleGreen, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: _wordleSurfaceLight,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildOptionRow(
                  icon: Icons.music_note_outlined,
                  title: l10n.ringtoneSetting,
                  subtitle: l10n.defaultAlarmSound,
                ),
                Divider(height: 1, color: _wordleBorder),
                _buildOptionRow(
                  icon: Icons.vibration,
                  title: l10n.vibrateLabel,
                  trailing: Switch(
                    value: _vibrate,
                    onChanged: (v) => setState(() => _vibrate = v),
                    activeTrackColor: _wordleGreen,
                    activeThumbColor: Colors.white,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: _wordleBorder,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}