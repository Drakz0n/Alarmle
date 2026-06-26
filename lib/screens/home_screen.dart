import 'package:alarmle/viewmodels/alarm_view_model.dart';
import 'package:alarmle/widgets/edit_alarm_sheet.dart';
import 'package:alarmle/widgets/add_alarm_sheet.dart';
import 'package:alarmle/models/alarm_model.dart';
import 'package:alarmle/widgets/alarm_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _wordleGreen = Color(0xFF57AC57);
const _wordleYellow = Color(0xFFC8B652);
const _wordleGray = Color(0xFF939393);
const _wordleDarkBg = Color(0xFF333333);
const _wordleSurface = Color(0xFF1C1C1E);
const _wordleTextSecondary = Color(0xFF8E8E93);
const _wordleBorder = Color(0xFF3A3A3C);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _selectionMode = false;
  final Set<String> _selectedIds = {};

  void _enterSelectionMode(String id) {
    setState(() {
      _selectionMode = true;
      _selectedIds.add(id);
    });
  }

  void _exitSelectionMode() {
    setState(() {
      _selectionMode = false;
      _selectedIds.clear();
    });
  }

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
        if (_selectedIds.isEmpty) _selectionMode = false;
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _selectAll(List alarms) {
    setState(() {
      _selectedIds.addAll(alarms.map((a) => a.id as String));
    });
  }

  void _deleteSelected() {
    final vm = context.read<AlarmViewModel>();
    for (final id in _selectedIds) {
      vm.deleteAlarm(id);
    }
    _exitSelectionMode();
  }

  void _openAddSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _wordleSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.92,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: AddAlarmSheet(
            onAlarmAdded: (alarm) =>
                context.read<AlarmViewModel>().addAlarm(alarm),
          ),
        ),
      ),
    );
  }

  void _openEditSheet(Alarm alarm) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _wordleSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.92,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: EditAlarmSheet(
            alarm: alarm,
            onAlarmEdited: (edited) =>
                context.read<AlarmViewModel>().editAlarm(edited),
          ),
        ),
      ),
    );
  }

  // ─── Wordle Logo: 7 bloques A-L-A-R-M-L-E (responsivo, sin overflow) ───
  Widget _buildWordleLogo() {
    const letters = ['A', 'L', 'A', 'R', 'M', 'L', 'E'];
    const colors = [
      _wordleGreen,
      _wordleYellow,
      _wordleGray,
      _wordleGreen,
      _wordleYellow,
      _wordleGray,
      _wordleGreen,
    ];
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(7, (i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: colors[i],
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: Text(
                letters[i],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: _wordleSurface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: _buildWordleLogo(),
            ),
            const Divider(color: _wordleBorder),
            const SizedBox(height: 8),
            _buildDrawerItem(
              icon: Icons.alarm,
              label: "Alarmas",
              selected: true,
              onTap: () => Navigator.pop(context),
            ),
            _buildDrawerItem(
              icon: Icons.settings_outlined,
              label: "Configuración",
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _buildDrawerItem(
              icon: Icons.info_outline,
              label: "Acerca de",
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            const Divider(color: _wordleBorder),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: const Text(
                "Versión 1.0.0",
                style: TextStyle(
                  color: Color(0xFF636366),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    bool selected = false,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: selected ? _wordleGreen : _wordleTextSecondary,
        size: 22,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: selected ? _wordleGreen : Colors.white,
          fontSize: 16,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      selectedTileColor: _wordleGreen.withValues(alpha: 0.1),
      selected: selected,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AlarmViewModel>();
    final alarms = vm.alarms;
    final allSelected = _selectedIds.length == alarms.length;

    return Scaffold(
      backgroundColor: _wordleDarkBg,
      endDrawer: _buildDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: _selectionMode
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: _exitSelectionMode,
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(color: _wordleGreen, fontSize: 16),
                          ),
                        ),
                        Text(
                          "${_selectedIds.length} seleccionado${_selectedIds.length != 1 ? 's' : ''}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: allSelected
                              ? _exitSelectionMode
                              : () => _selectAll(alarms),
                          child: Text(
                            allSelected
                                ? "Deseleccionar todo"
                                : "Seleccionar todo",
                            style: const TextStyle(
                                color: _wordleGreen, fontSize: 16),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        const SizedBox(width: 48),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildWordleLogo(),
                                const SizedBox(height: 6),
                                Text(
                                  vm.nextAlarmText,
                                  style: const TextStyle(
                                    color: _wordleTextSecondary,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Builder(
                          builder: (context) => IconButton(
                            onPressed: () => Scaffold.of(context).openEndDrawer(),
                            icon: const Icon(Icons.menu, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: alarms.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.alarm_off,
                              size: 64, color: _wordleBorder),
                          SizedBox(height: 16),
                          Text(
                            "Sin alarmas",
                            style: TextStyle(
                              color: _wordleTextSecondary,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Toca + para agregar una",
                            style: TextStyle(
                              color: Color(0xFF636366),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: alarms.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final alarm = alarms[index];
                        final isSelected =
                            _selectedIds.contains(alarm.id);
                        return AlarmCard(
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
                              : () => _openEditSheet(alarm),
                          onLongPress: _selectionMode
                              ? null
                              : () => _enterSelectionMode(alarm.id),
                        );
                      },
                    ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _selectionMode
                  ? Container(
                      key: const ValueKey('delete_bar'),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        color: _wordleSurface,
                        border: Border(
                          top: BorderSide(
                              color: _wordleBorder, width: 0.5),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: _selectedIds.isEmpty ? null : _deleteSelected,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: _selectedIds.isEmpty
                                  ? const Color(0xFF636366)
                                  : Colors.red,
                              size: 26,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Eliminar",
                              style: TextStyle(
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
          : FloatingActionButton(
              onPressed: _openAddSheet,
              backgroundColor: _wordleGreen,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
    );
  }
}