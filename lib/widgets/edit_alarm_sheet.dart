import 'package:alarmle/models/alarm_model.dart';
import 'package:flutter/material.dart';

class EditAlarmSheet extends StatefulWidget 
{
  final Alarm alarm;
  final Function(Alarm) onAlarmEdited;

  const EditAlarmSheet
  ({
    super.key,
    required this.alarm,
    required this.onAlarmEdited,
  });

  @override
  State<EditAlarmSheet> createState() => _EditAlarmSheetState();
}

class _EditAlarmSheetState extends State<EditAlarmSheet> 
{
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

  static const _surface        = Color(0xFF2C2C2E);
  static const _accent         = Color(0xFF0A84FF);
  static const _textPrimary    = Colors.white;
  static const _textSecondary  = Color(0xFF8E8E93);
  static const _border         = Color(0xFF3A3A3C);
  static const _dayLabels      = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
  static const _loopMultiplier = 1000;

  @override
  void initState() 
  {
    super.initState();

    final a = widget.alarm;

    //convertir las horas
    _isPM   = a.hour >= 12;
    _hour   = a.hour % 12 == 0 ? 12 : a.hour % 12;
    _minute = a.minute;

    //repeticion de los dias
    final anyDay = a.repeatDays.any((d) => d);
    _repeatOnce = !anyDay;
    _repeatDays = List<bool>.from(a.repeatDays);

    _vibrate = a.vibrate;

    _titleController = TextEditingController(text: a.title);

    _hourController = FixedExtentScrollController
    (
      initialItem: _loopMultiplier * 12 + (_hour - 1),
    );
    _minuteController = FixedExtentScrollController
    (
      initialItem: _loopMultiplier * 60 + _minute,
    );
    _periodController = FixedExtentScrollController
    (
      initialItem: _isPM ? 1 : 0,
    );
  }

  @override
  void dispose() 
  {
    _titleController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  //vista previa de la siguiente alarma
  String _nextAlarmPreview() 
  {
    final now = DateTime.now();
    final int hour24 = _isPM
        ? (_hour == 12 ? 12 : _hour + 12)
        : (_hour == 12 ? 0 : _hour);

    DateTime? trigger;

    if (_repeatOnce) 
    {
      final today = DateTime(now.year, now.month, now.day, hour24, _minute);
      trigger = today.isAfter(now) ? today : today.add(const Duration(days: 1));
    } 
    else
     {
      final anySelected = _repeatDays.any((d) => d);
      if (!anySelected) return "Selecciona al menos un día";

      for (int offset = 0; offset < 7; offset++) 
      {
        final candidate = DateTime
        (
          now.year, now.month, now.day, hour24, _minute,
        ).add(Duration(days: offset));

        final dayIndex = candidate.weekday - 1;
        if (_repeatDays[dayIndex] && candidate.isAfter(now)) 
        {
          trigger = candidate;
          break;
        }
      }
      trigger ??= DateTime(now.year, now.month, now.day, hour24, _minute)
          .add(const Duration(days: 7));
    }

    final diff  = trigger.difference(now);
    final days  = diff.inDays;
    final hours = diff.inHours % 24;
    final mins  = diff.inMinutes % 60;

    if (days >= 1) 
    {
      if (hours > 0) return "Siguiente alarma en $days día${days > 1 ? 's' : ''} ${hours}h ${mins}min";
      return "Siguiente alarma en $days día${days > 1 ? 's' : ''} y ${mins}min";
    }
    if (hours > 0) return "Siguiente alarma en ${hours}h ${mins}min";
    return "Siguiente alarma en $mins minuto${mins != 1 ? 's' : ''}";
  }

  void _submit() 
  {
    final int hour24 = _isPM
        ? (_hour == 12 ? 12 : _hour + 12)
        : (_hour == 12 ? 0 : _hour);

    final days = _repeatOnce
        ? List.filled(7, false)
        : List<bool>.from(_repeatDays);

    widget.onAlarmEdited(Alarm
    (
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

  Widget _buildDrumPicker() 
  {
    return SizedBox
    (
      height: 160,
      child: Row
      (
        children: 
        [
          Expanded
          (
            child: _buildLoopScroller
            (
              controller: _hourController,
              itemCount: 12,
              label: (i) => (i + 1).toString(),
              onChanged: (i) => setState(() => _hour = (i % 12) + 1),
            ),
          ),

          Padding
          (
            padding: const EdgeInsets.only(bottom: 4),
            child: Text
            (
              ':',
              style: TextStyle
              (
                fontSize: 36,
                fontWeight: FontWeight.w200,
                color: _textPrimary,
              ),
            ),
          ),

          Expanded
          (
            child: _buildLoopScroller
            (
              controller: _minuteController,
              itemCount: 60,
              label: (i) => (i % 60).toString().padLeft(2, '0'),
              onChanged: (i) => setState(() => _minute = i % 60),
            ),
          ),
          const SizedBox(width: 8),

          SizedBox
          (
            width: 72,
            child: ListWheelScrollView
            (
              controller: _periodController,
              itemExtent: 52,
              diameterRatio: 1.4,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (i) => setState(() => _isPM = i == 1),
              children: ['a. m.', 'p. m.'].map((label) 
              {
                return Center
                (
                  child: Text
                  (
                    label,
                    style: const TextStyle
                    (
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: _textPrimary,
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

  Widget _buildLoopScroller
  ({
    required FixedExtentScrollController controller,
    required int itemCount,
    required String Function(int) label,
    required Function(int) onChanged,
  }) 

  {
    final totalItems = itemCount * _loopMultiplier * 2;
    return ListWheelScrollView.useDelegate
    (
      controller: controller,
      itemExtent: 52,
      diameterRatio: 1.4,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: onChanged,
      childDelegate: ListWheelChildBuilderDelegate
      (
        childCount: totalItems,
        builder: (context, index) => Center
        (
          child: Text
          (
            label(index % itemCount),
            style: const TextStyle
            (
              fontSize: 36,
              fontWeight: FontWeight.w200,
              color: _textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  //repeticion
  Widget _buildRepeatSection() 
  {
    return Column
    (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: 
      [
        Center
        (
          child: Row
          (
            mainAxisSize: MainAxisSize.min,
            children: 
            [
              _buildRepeatChip
              (
                label: 'Una vez',
                selected: _repeatOnce,
                onTap: () => setState(() => _repeatOnce = true),
              ),
              const SizedBox(width: 10),

              _buildRepeatChip
              (
                label: 'Personalizar',
                selected: !_repeatOnce,
                onTap: () => setState(() => _repeatOnce = false),
              ),
            ],
          ),
        ),
        if (!_repeatOnce) ...
        [
          const SizedBox(height: 16),
          Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) 
            {
              final selected = _repeatDays[i];
              return GestureDetector
              (
                onTap: () => setState(() => _repeatDays[i] = !selected),
                child: AnimatedContainer
                (
                  duration: const Duration(milliseconds: 150),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration
                  (
                    shape: BoxShape.circle,
                    color: selected ? _accent : _surface,
                    border: selected ? null : Border.all(color: _border),
                  ),
                  alignment: Alignment.center,
                  child: Text
                  (
                    _dayLabels[i],
                    style: TextStyle
                    (
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: selected ? Colors.white : _textSecondary,
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

  Widget _buildRepeatChip
  ({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) 
  
  {
    return GestureDetector
    (
      onTap: onTap,
      child: AnimatedContainer
      (
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(

          color: selected ? _accent : _surface,
          borderRadius: BorderRadius.circular(20),
          border: selected ? null : Border.all(color: _border),
        ),

        child: Text
        (
          label,
          style: TextStyle
          (
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : _textSecondary,
          ),
        ),
      ),
    );
  }

  //opciones
  Widget _buildOptionRow
  ({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) 
  
  {
    return InkWell
    (
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding
      (
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        child: Row
        (
          children: 
          [
            Icon(icon, color: _textSecondary, size: 20),
            const SizedBox(width: 14),
            Expanded
            (
              child: Column
              (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: 
                [
                  Text(title,
                      style: const TextStyle(color: _textPrimary, fontSize: 15)),
                  if (subtitle != null)
                    Text(subtitle,
                        style: const TextStyle(color: _textSecondary, fontSize: 13)),
                ],
              ),
            ),
            trailing ??
                const Icon(Icons.chevron_right, color: _textSecondary, size: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    return Padding
    (
      padding: EdgeInsets.only
      (
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),

      child: Column
      (
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: 
        [
          Center
          (
            child: Container
            (
              width: 36,
              height: 4,
              decoration: BoxDecoration
              (
                color: _border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Column
          (
            children: 
            [
              Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: 
                [
                  GestureDetector
                  (
                    onTap: () => Navigator.pop(context),
                    child: const Text("Cancelar", style: TextStyle(color: _accent, fontSize: 16)),
                  ),

                  const Text
                  (
                    "Editar alarma",
                    style: TextStyle
                    (
                      color: _textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  GestureDetector
                  (
                    onTap: _submit,
                    child: const Text
                    (
                      "Hecho",
                      style: TextStyle
                      (
                        color: _accent,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              Center
              (
                child: Text
                (
                  _nextAlarmPreview(),
                  style: const TextStyle
                  (color: _textSecondary, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _buildDrumPicker(),
          const SizedBox(height: 24),

          _buildRepeatSection(),
          const SizedBox(height: 20),

          //nombre
          TextField
          (
            controller: _titleController,
            style: const TextStyle(color: _textPrimary),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration
            (
              hintText: "Nombre de la alarma",
              hintStyle: const TextStyle(color: _textSecondary),
              prefixIcon:
                  const Icon(Icons.label_outline, color: _textSecondary),
              filled: true,
              fillColor: _surface,
              border: OutlineInputBorder
              (
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),

              enabledBorder: OutlineInputBorder
              (
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),

              focusedBorder: OutlineInputBorder
              (
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _accent, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 8),

          //tono y vibracion
          Container
          (
            decoration: BoxDecoration
            (
              color: _surface,
              borderRadius: BorderRadius.circular(16),
            ),

            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column
            (
              children: 
              [
                _buildOptionRow
                (
                  icon: Icons.music_note_outlined,
                  title: 'Tono de llamadas',
                  subtitle: 'Sonido de alarma predeterminado',
                ),
                Divider(height: 1, color: _border),

                _buildOptionRow
                (
                  icon: Icons.vibration,
                  title: 'Vibrar',
                  trailing: Switch
                  (
                    value: _vibrate,
                    onChanged: (v) => setState(() => _vibrate = v),
                    activeColor: Colors.white,
                    activeTrackColor: _accent,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: _border,
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