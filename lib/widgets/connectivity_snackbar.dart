import 'package:alarmle/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ConnectivitySnackBar {
  static void show(BuildContext context, bool isConnected) {
    final l10n = AppLocalizations.of(context);
    final message = isConnected ? l10n.online : l10n.offline;
    final backgroundColor = isConnected ? const Color(0xFF57AC57) : Colors.red;
    
    // Si está desconectado, duración infinita. Si está conectado, 3 segundos.
    final duration = isConnected ? const Duration(seconds: 3) : const Duration(days: 365);

    // Cerrar cualquier SnackBar activo antes de mostrar el nuevo
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isConnected ? Icons.wifi : Icons.wifi_off,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
