import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/custom_text_field.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/custom_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_protfolio/core/presentation/widgets/custom_cursor.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Assuming hardcoded admin in Supabase Auth, or simple auth check
      await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      
      debugPrint('✅ Admin login successful! Email: ${_emailController.text.trim()}');
      
      if (mounted) {
        context.go('/admin');
      }
    } on AuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.1),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.admin_panel_settings,
                    size: 60,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Admin Portal',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                if (_errorMessage != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.withValues(alpha: 0.5)),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                CustomTextField(
                  labelText: 'Admin Email',
                  controller: _emailController,
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Email required' : null,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Password',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Password required' : null,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'LOGIN',
                  isLoading: _isLoading,
                  onPressed: _handleLogin,
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => context.go('/'),
                    child: Text(
                      'Back to Portfolio',
                      style: TextStyle(color: theme.hintColor),
                    ),
                  ).withCursorHover(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
