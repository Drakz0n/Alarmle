import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_view_model.dart';
import '../main.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  bool _editingName = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserViewModel>().user;
    _nameController = TextEditingController(text: user?.name ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveName() {
    final vm = context.read<UserViewModel>();
    vm.updateName(_nameController.text.trim());
    setState(() => _editingName = false);
  }

  @override
  Widget build(BuildContext context) {
    final vm   = context.watch<UserViewModel>();
    final user = vm.user;

    return Scaffold(
      backgroundColor: wordleDarkBg,
      appBar: AppBar(
        backgroundColor: wordleDarkBg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Perfil',
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Row(
                children: [
                  Container(
                    width: 8, height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: vm.isConnected ? wordleGreen : Colors.red,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    vm.isConnected ? 'En línea' : 'Sin conexión',
                    style: TextStyle(
                      color: vm.isConnected ? wordleGreen : Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () => vm.pickPhoto(),
                          child: CircleAvatar(
                            radius: 48,
                            backgroundColor: wordleSurfaceLight,
                            backgroundImage: _resolvePhoto(vm),
                            child: _resolvePhoto(vm) == null
                                ? Icon(Icons.person,
                                    size: 48, color: wordleGray)
                                : null,
                          ),
                        ),
                        Positioned(
                          bottom: 0, right: 0,
                          child: GestureDetector(
                            onTap: () => vm.pickPhoto(),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: wordleGreen,
                                shape: BoxShape.circle,
                                border: Border.all(color: wordleDarkBg, width: 2),
                              ),
                              child: const Icon(Icons.camera_alt,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    if (_editingName)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 180,
                            child: TextField(
                              controller: _nameController,
                              autofocus: true,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: wordleGreen)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: wordleGreen, width: 2)),
                              ),
                              onSubmitted: (_) => _saveName(),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.check, color: wordleGreen, size: 20),
                            onPressed: _saveName,
                          ),
                        ],
                      )
                    else
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user?.name ?? 'Usuario',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => setState(() => _editingName = true),
                            child: Icon(Icons.edit,
                                size: 16, color: wordleTextSecondary),
                          ),
                        ],
                      ),

                    if (vm.isLoggedIn && !vm.isGuest) ...[
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? '',
                        style: TextStyle(
                            color: wordleTextSecondary, fontSize: 13),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),

              _buildSection(
                title: 'Puntuación',
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: wordleSurface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star_rounded,
                          color: wordleYellow, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user?.score ?? 0} puntos',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Puntos acumulados',
                              style: TextStyle(
                                  color: wordleTextSecondary, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      FilledButton(
                        onPressed: () => vm.incrementScore(),
                        style: FilledButton.styleFrom(
                          backgroundColor: wordleGreen,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('+1',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              _buildSection(
                title: 'Cuenta',
                child: Container(
                  decoration: BoxDecoration(
                    color: wordleSurface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: vm.isLoggedIn && !vm.isGuest
                      ? _buildLoggedInAccount(vm)
                      : _buildGuestAccount(),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoggedInAccount(UserViewModel vm) {
    return Column(
      children: [
        _buildInfoRow(
          icon: Icons.person_outline,
          label: 'Nombre',
          value: vm.user?.name ?? '',
        ),
        Divider(height: 1, color: wordleBorder, indent: 52),
        _buildInfoRow(
          icon: Icons.email_outlined,
          label: 'Correo',
          value: vm.user?.email ?? '',
        ),
        Divider(height: 1, color: wordleBorder, indent: 52),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red, size: 20),
          title: const Text('Cerrar sesión',
              style: TextStyle(color: Colors.red, fontSize: 15)),
          onTap: () async {
            await vm.signOut();
            if (mounted) Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _buildGuestAccount() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Inicia sesión para sincronizar tus datos y no perderlos',
            style: TextStyle(color: wordleTextSecondary, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: wordleGreen,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Iniciar sesión / Registrarse',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: wordleTextSecondary, size: 20),
      title: Text(label,
          style: TextStyle(color: wordleTextSecondary, fontSize: 14)),
      trailing: Text(value,
          style: const TextStyle(color: Colors.white, fontSize: 14)),
    );
  }

  ImageProvider? _resolvePhoto(UserViewModel vm) {
    if (vm.user?.photoPath != null && vm.user!.photoPath!.isNotEmpty) {
      return FileImage(File(vm.user!.photoPath!));
    }
    if (vm.googlePhotoUrl != null) {
      return NetworkImage(vm.googlePhotoUrl!);
    }
    return null;
  }
}