import 'package:alarmle/viewmodels/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget 
{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> 
{
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isRegister = false;
  bool _obscurePassword = true;
  String? _errorMessage;
  bool _verificationSent = false;

  static const _bg      = Color(0xFF0D0D0D);
  static const _surface = Color(0xFF1C1C1E);
  static const _accent  = Color(0xFF0A84FF);
  static const _border  = Color(0xFF3A3A3C);
  static const _textSecondary = Color(0xFF8E8E93);

  @override
  void dispose() 
  {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleGoogle() async 
  {
    final vm = context.read<UserViewModel>();
    final error = await vm.signInWithGoogle();
    if (!mounted) return;
    if (error != null) setState(() => _errorMessage = error);
    else Navigator.pop(context);
  }

  Future<void> _handleEmail() async 
  {
    final vm = context.read<UserViewModel>();
    setState(() { _errorMessage = null; _verificationSent = false; });

    final email    = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name     = _nameController.text.trim();

    if (email.isEmpty || password.isEmpty) 
    {
      setState(() => _errorMessage = 'Completa todos los campos');
      return;
    }

    String? result;
    if (_isRegister) 
    {
      result = await vm.registerWithEmail(email, password, name);
    } 
    else 
    {
      result = await vm.signInWithEmail(email, password);
    }

    if (!mounted) return;

    if (result == 'verify_email') 
    {
      setState(() => _verificationSent = true);
    } 
    else if (result == 'email_not_verified') 
    {
      setState(() 
      {
        _verificationSent = true; 
        _errorMessage = null;
      });
    } 
    else if (result != null) 
    {
      setState(() => _errorMessage = result);
    } 
    else 
    {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    final vm = context.watch<UserViewModel>();

    return Scaffold
    (
      backgroundColor: _bg,
      appBar: AppBar
      (
        backgroundColor: _bg,
        leading: IconButton
        (
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),

        title: Text
        (
          _isRegister ? 'Crear cuenta' : 'Iniciar sesión',
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ),
        centerTitle: true,
      ),

      body: SafeArea
      (
        child: SingleChildScrollView
        (
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: 
            [
              const SizedBox(height: 32),

              //mensaje de verificacion
              if (_verificationSent) ...
              [
                Container
                (
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration
                  (
                    color: const Color(0xFF1C3A1C),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade700),
                  ),

                  child: Column
                  (
                    children: 
                    [
                      const Icon(Icons.mark_email_read_outlined,
                          color: Colors.green, size: 36),
                      const SizedBox(height: 8),
                      const Text
                      (
                        'Revisa tu correo',
                        style: TextStyle
                        (
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(height: 4),

                      Text
                      (
                        'Enviamos un enlace de verificación a ${_emailController.text.trim()}',
                        style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      TextButton
                      (
                        onPressed: () => context.read<UserViewModel>()
                            .signOut().then((_) => Navigator.pop(context)),
                        child: const Text('Volver al inicio',
                            style: TextStyle(color: _accent)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              if (!_verificationSent) ...
              [
                //google
                _buildGoogleButton(vm.isLoading),
                const SizedBox(height: 20),

                Row
                (
                  children: 
                  [
                    const Expanded(child: Divider(color: _border)),
                    Padding
                    (
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('o', style: TextStyle(color: _textSecondary)),
                    ),
                    const Expanded(child: Divider(color: _border)),
                  ],
                ),
                const SizedBox(height: 20),

                //nombre
                if (_isRegister) ...
                [
                  _buildTextField
                  (
                    controller: _nameController,
                    hint: 'Tu nombre',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 10),
                ],

                //email
                _buildTextField
                (
                  controller: _emailController,
                  hint: 'Ingresa tu correo electrónico',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),

                //contraseña
                _buildTextField
                (
                  controller: _passwordController,
                  hint: 'Contraseña',
                  icon: Icons.lock_outline,
                  obscure: _obscurePassword,
                  suffixIcon: IconButton
                  (
                    icon: Icon
                    (
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: _textSecondary,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const SizedBox(height: 16),

                //error
                if (_errorMessage != null) ...
                [
                  Text
                  (
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                ],

                //boton principal
                FilledButton
                (
                  onPressed: vm.isLoading ? null : _handleEmail,
                  style: FilledButton.styleFrom
                  (
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),

                  child: vm.isLoading
                      ? const SizedBox
                      (
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                      )
                      : Text
                      (
                        _isRegister
                            ? 'Crear cuenta'
                            : 'Continuar con correo electrónico',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                ),
                const SizedBox(height: 16),

                //registro/inicio de sesion
                Center
                (
                  child: TextButton
                  (
                    onPressed: () => setState(() 
                    {
                      _isRegister = !_isRegister;
                      _errorMessage = null;
                    }),

                    child: Text
                    (
                      _isRegister
                          ? '¿Ya tienes cuenta? Inicia sesión'
                          : '¿No tienes cuenta? Regístrate',
                      style: const TextStyle(color: _accent, fontSize: 14),
                    ),
                  ),
                ),

                //aviso legal
                const SizedBox(height: 8),
                const Text
                (
                  'Al continuar, aceptas los Términos de servicio y la Política de privacidad.',
                  style: TextStyle(color: _textSecondary, fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleButton(bool loading) 
  {
    return OutlinedButton
    (
      onPressed: loading ? null : _handleGoogle,
      style: OutlinedButton.styleFrom
      (
        side: const BorderSide(color: _border),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: _surface,
      ),

      child: Row
      (
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
        [
          Image.network
          (
            'https://www.google.com/favicon.ico',
            width: 18, height: 18,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.g_mobiledata, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),

          const Text
          (
            'Continuar con Google',
            style: TextStyle
            (
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField
  ({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) 
  {
    return TextField
    (
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration
      (
        hintText: hint,
        hintStyle: const TextStyle(color: _textSecondary),
        prefixIcon: Icon(icon, color: _textSecondary, size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: _surface,
        border: OutlineInputBorder
        (
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none
        ),

        enabledBorder: OutlineInputBorder
        (
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none
        ),

        focusedBorder: OutlineInputBorder
        (
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _accent, width: 1.5),
        ),
      ),
    );
  }
}