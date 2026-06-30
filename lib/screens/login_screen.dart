import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_view_model.dart';
import '../main.dart'; // para las constantes wordle*

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isRegister = false;
  bool _obscurePassword = true;
  String? _errorMessage;
  bool _verificationSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleGoogle() async {
    final vm = context.read<UserViewModel>();
    final error = await vm.signInWithGoogle();
    if (!mounted) return;
    if (error != null) setState(() => _errorMessage = error);
    else Navigator.pop(context);
  }

  Future<void> _handleEmail() async {
    final vm = context.read<UserViewModel>();
    setState(() { _errorMessage = null; _verificationSent = false; });

    final email    = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name     = _nameController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Completa todos los campos');
      return;
    }

    String? result;
    if (_isRegister) {
      result = await vm.registerWithEmail(email, password, name);
    } else {
      result = await vm.signInWithEmail(email, password);
    }

    if (!mounted) return;

    if (result == 'verify_email' || result == 'email_not_verified') {
      setState(() => _verificationSent = true);
    } else if (result != null) {
      setState(() => _errorMessage = result);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UserViewModel>();

    return Scaffold(
      backgroundColor: wordleDarkBg,
      appBar: AppBar(
        backgroundColor: wordleDarkBg,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _isRegister ? 'Crear cuenta' : 'Iniciar sesión',
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),

              if (_verificationSent) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C3A1C),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: wordleGreen),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.mark_email_read_outlined,
                          color: wordleGreen, size: 36),
                      const SizedBox(height: 8),
                      const Text(
                        'Revisa tu correo',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Enviamos un enlace de verificación a ${_emailController.text.trim()}',
                        style: const TextStyle(
                            color: wordleTextSecondary, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => context.read<UserViewModel>()
                            .signOut().then((_) => Navigator.pop(context)),
                        child: Text('Volver al inicio',
                            style: TextStyle(color: wordleGreen)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              if (!_verificationSent) ...[
                _buildGoogleButton(vm.isLoading),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(child: Divider(color: wordleBorder)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('o',
                          style: TextStyle(color: wordleTextSecondary)),
                    ),
                    Expanded(child: Divider(color: wordleBorder)),
                  ],
                ),
                const SizedBox(height: 20),

                if (_isRegister) ...[
                  _buildTextField(
                    controller: _nameController,
                    hint: 'Tu nombre',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 10),
                ],

                _buildTextField(
                  controller: _emailController,
                  hint: 'Ingresa tu correo electrónico',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),

                _buildTextField(
                  controller: _passwordController,
                  hint: 'Contraseña',
                  icon: Icons.lock_outline,
                  obscure: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: wordleTextSecondary,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const SizedBox(height: 16),

                if (_errorMessage != null) ...[
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                ],

                FilledButton(
                  onPressed: vm.isLoading ? null : _handleEmail,
                  style: FilledButton.styleFrom(
                    backgroundColor: wordleGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: vm.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Text(
                          _isRegister
                              ? 'Crear cuenta'
                              : 'Continuar con correo electrónico',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                ),
                const SizedBox(height: 16),

                Center(
                  child: TextButton(
                    onPressed: () => setState(() {
                      _isRegister = !_isRegister;
                      _errorMessage = null;
                    }),
                    child: Text(
                      _isRegister
                          ? '¿Ya tienes cuenta? Inicia sesión'
                          : '¿No tienes cuenta? Regístrate',
                      style: TextStyle(color: wordleGreen, fontSize: 14),
                    ),
                  ),
                ),

                const SizedBox(height: 8),
                const Text(
                  'Al continuar, aceptas los Términos de servicio y la Política de privacidad.',
                  style: TextStyle(color: wordleTextSecondary, fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleButton(bool loading) {
    return OutlinedButton(
      onPressed: loading ? null : _handleGoogle,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: wordleBorder),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: wordleSurface,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://www.google.com/favicon.ico',
            width: 18, height: 18,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.g_mobiledata, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          const Text(
            'Continuar con Google',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: wordleTextSecondary),
        prefixIcon: Icon(icon, color: wordleTextSecondary, size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: wordleSurface,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: wordleGreen, width: 1.5),
        ),
      ),
    );
  }
}