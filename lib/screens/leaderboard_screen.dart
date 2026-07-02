import 'dart:io';
import 'package:alarmle/models/user_model.dart';
import 'package:alarmle/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _wordleGreen = Color(0xFF57AC57);
const _wordleDarkBg = Color(0xFF333333);
const _wordleSurface = Color(0xFF1C1C1E);
const _wordleTextSecondary = Color(0xFF8E8E93);
const _wordleBorder = Color(0xFF3A3A3C);

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().fetchLeaderboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UserViewModel>();

    return Scaffold(
      backgroundColor: _wordleDarkBg,
      appBar: AppBar(
        backgroundColor: _wordleSurface,
        foregroundColor: Colors.white,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.emoji_events, color: _wordleGreen, size: 24),
            SizedBox(width: 8),
            Text(
              "Ranking",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: vm.isLeaderboardLoading
            ? const Center(
                child: CircularProgressIndicator(color: _wordleGreen),
              )
            : vm.leaderboard.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.emoji_events_outlined,
                            size: 64, color: _wordleBorder),
                        SizedBox(height: 16),
                        Text(
                          "Sin datos",
                          style: TextStyle(
                            color: _wordleTextSecondary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Aún no hay jugadores en el ranking",
                          style: TextStyle(
                            color: Color(0xFF636366),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    itemCount: vm.leaderboard.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final user = vm.leaderboard[index];
                      return _LeaderboardTile(
                        position: index + 1,
                        user: user,
                      );
                    },
                  ),
      ),
    );
  }
}

class _LeaderboardTile extends StatelessWidget {
  final int position;
  final UserModel user;

  const _LeaderboardTile({required this.position, required this.user});

  @override
  Widget build(BuildContext context) {
    final isTop3 = position <= 3;
    final isTop1 = position == 1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isTop3 ? _wordleGreen.withValues(alpha: 0.08) : _wordleSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isTop1 ? _wordleGreen : _wordleBorder,
          width: isTop1 ? 1.5 : 0.5,
        ),
      ),
      child: Row(
        children: [
          // Posición
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isTop3 ? _wordleGreen : _wordleBorder,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              position.toString(),
              style: TextStyle(
                color: isTop3 ? Colors.white : _wordleTextSecondary,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _wordleBorder,
              image: user.photoPath != null && user.photoPath!.isNotEmpty
                  ? DecorationImage(
                      image: FileImage(File(user.photoPath!)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: user.photoPath == null || user.photoPath!.isEmpty
                ? const Icon(Icons.person, color: _wordleTextSecondary, size: 24)
                : null,
          ),
          const SizedBox(width: 12),
          // Nombre
          Expanded(
            child: Text(
              user.name,
              style: TextStyle(
                color: isTop3 ? Colors.white : _wordleTextSecondary,
                fontSize: 16,
                fontWeight: isTop3 ? FontWeight.w600 : FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Score
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                color: isTop3 ? _wordleGreen : _wordleTextSecondary,
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                user.score.toString(),
                style: TextStyle(
                  color: isTop3 ? _wordleGreen : Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}