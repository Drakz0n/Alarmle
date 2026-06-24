import 'package:alarmle/viewmodels/alarm_view_model.dart';
import 'package:alarmle/viewmodels/alarm_view_model.dart';
import 'package:alarmle/widgets/add_alarm_sheet.dart';
import 'package:alarmle/widgets/add_alarm_sheet.dart';
import 'package:alarmle/widgets/alarm_card.dart';
import 'package:alarmle/widgets/alarm_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget 
{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> 
{
  bool _selectionMode = false;
  final Set<String> _selectedIds = {};

  static const _accent = Color(0xFF0A84FF);
  static const _surface = Color(0xFF1C1C1E);
  static const _textSecondary = Color(0xFF8E8E93);

  void _enterSelectionMode(String id) 
  {
    setState(() 
    {
      _selectionMode = true;
      _selectedIds.add(id);
    });
  }

  void _exitSelectionMode() 
  {
    setState(() 
    {
      _selectionMode = false;
      _selectedIds.clear();
    });
  }

  void _toggleSelection(String id) 
  {
    setState(() 
    {
      if (_selectedIds.contains(id)) 
      {
        _selectedIds.remove(id);
        if (_selectedIds.isEmpty) _selectionMode = false;
      } 
      else 
      {
        _selectedIds.add(id);
      }
    });
  }

  void _selectAll(List alarms) 
  {
    setState(() 
    {
      _selectedIds.addAll(alarms.map((a) => a.id as String));
    });
  }

  void _deleteSelected() 
  {
    final vm = context.read<AlarmViewModel>();
    for (final id in _selectedIds) 
    {
      vm.deleteAlarm(id);
    }
    _exitSelectionMode();
  }

  void _openAddSheet() 
  {
    showModalBottomSheet
    (
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1C1C1E),
      shape: const RoundedRectangleBorder
      (
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DraggableScrollableSheet
      (
        expand: false,
        initialChildSize: 0.92,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => SingleChildScrollView
        (
          controller: scrollController,
          child: AddAlarmSheet
          (
            onAlarmAdded: (alarm) =>
                context.read<AlarmViewModel>().addAlarm(alarm),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    final vm = context.watch<AlarmViewModel>();
    final alarms = vm.alarms;
    final allSelected = _selectedIds.length == alarms.length;

    return Scaffold
    (
      backgroundColor: Colors.black,
      body: SafeArea
      (
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          [
            Padding
            (
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: _selectionMode
                ? Row
                (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: 
                    [
                      GestureDetector
                      (
                        onTap: _exitSelectionMode,
                        child: const Text
                        (
                          "Cancelar",
                          style:
                          TextStyle(color: _accent, fontSize: 16)
                        ),
                      ),

                      Text
                      (
                        "${_selectedIds.length} seleccionado${_selectedIds.length != 1 ? 's' : ''}",
                        style: const TextStyle
                        (
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      GestureDetector
                      (
                        onTap: allSelected
                            ? _exitSelectionMode
                            : () => _selectAll(alarms),
                        child: Text
                        (
                          allSelected
                              ? "Deseleccionar todo"
                              : "Seleccionar todo",
                          style: const TextStyle(
                              color: _accent, fontSize: 16),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  )
                  : Row
                  (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: 
                      [
                        Column
                        (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: 
                          [
                            const Text
                            (
                              "Alarmle",
                              style: TextStyle
                              (
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 2),

                            Text
                            (
                              vm.nextAlarmText,
                              style: const TextStyle
                              (
                                color: _textSecondary,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        IconButton
                        (
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert,
                              color: Colors.white),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 16),

            Expanded
            (
              child: alarms.isEmpty
                  ? const Center
                  (
                      child: Column
                      (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: 
                        [
                          Icon(Icons.alarm_off,
                              size: 64, color: Color(0xFF3A3A3C)),
                          SizedBox(height: 16),
                          Text
                          (
                            "Sin alarmas",
                            style: TextStyle
                            (
                              color: _textSecondary,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),

                          Text
                          (
                            "Toca + para agregar una",
                            style: TextStyle
                            (
                              color: Color(0xFF636366),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated
                  (
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: alarms.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) 
                      {
                        final alarm = alarms[index];
                        final isSelected =
                            _selectedIds.contains(alarm.id);
                        return AlarmCard
                        (
                          alarm: alarm,
                          onToggle: _selectionMode
                              ? (_) {}
                              : (val) =>
                                  vm.toggleAlarm(alarm.id, val),
                          onDelete: () => vm.deleteAlarm(alarm.id),
                          selectionMode: _selectionMode,
                          isSelected: isSelected,
                          onTap: _selectionMode
                              ? () => _toggleSelection(alarm.id)
                              : null,
                          onLongPress: _selectionMode
                              ? null
                              : () => _enterSelectionMode(alarm.id),
                        );
                      },
                    ),
            ),

            AnimatedSwitcher
            (
              duration: const Duration(milliseconds: 200),
              child: _selectionMode
                  ? Container
                  (
                      key: const ValueKey('delete_bar'),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration
                      (
                        color: Color(0xFF1C1C1E),
                        border: Border
                        (
                          top: BorderSide
                          (color: Color(0xFF3A3A3C), width: 0.5),
                        ),
                      ),
                      child: GestureDetector
                      (
                        onTap: _selectedIds.isEmpty ? null : _deleteSelected,
                        child: Column
                        (
                          mainAxisSize: MainAxisSize.min,
                          children: 
                          [
                            Icon
                            (
                              Icons.delete_outline,
                              color: _selectedIds.isEmpty
                                  ? const Color(0xFF636366)
                                  : Colors.red,
                              size: 26,
                            ),
                            const SizedBox(height: 4),

                            Text
                            (
                              "Eliminar",
                              style: TextStyle
                              (
                                color: _selectedIds.isEmpty
                                    ? const Color(0xFF636366)
                                    : Colors.red,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(key: ValueKey('no_bar')),
            ),
          ],
        ),
      ),

      floatingActionButton: _selectionMode
          ? null
          : FloatingActionButton
          (
            onPressed: _openAddSheet,
            backgroundColor: _accent,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
          
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
    );
  }
}