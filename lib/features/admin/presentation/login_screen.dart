import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_protfolio/core/constants/app_assets.dart';
import 'package:my_protfolio/core/constants/colors.dart';
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

  User? get _currentUser {
    try {
      return Supabase.instance.client.auth.currentUser;
    } catch (_) {
      return null;
    }
  }

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

  Future<void> _handleSignOut() async {
    try {
      await Supabase.instance.client.auth.signOut();
      if (mounted) {
        setState(() {
          _errorMessage = null;
        });
      }
    } catch (e) {
      debugPrint('Sign out note: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentUser = _currentUser;
    
    return Scaffold(
      body: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(36),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.12),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                        .withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.admin_panel_settings,
                    size: 52,
                    color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Admin Portal',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // ── Active Session Profile Card ──
              if (currentUser != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.primaryLight.withValues(alpha: 0.08)
                        : AppColors.primaryDark.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                          .withValues(alpha: 0.25),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundImage: AssetImage(AppAssets.profileAvatar),
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Active Session',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  currentUser.email ?? 'Logged-in Admin',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : AppColors.primaryDark,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'CONTINUE TO ADMIN PANEL',
                        isLoading: false,
                        onPressed: () => context.go('/admin'),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: _handleSignOut,
                        child: Text(
                          'Switch Account / Sign Out',
                          style: TextStyle(
                            color: Colors.red.shade400,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ).withCursorHover(context),
                    ],
                  ),
                ),
              ] else ...[
                // ── Login Form ──
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                      const SizedBox(height: 30),
                      CustomButton(
                        text: 'LOGIN',
                        isLoading: _isLoading,
                        onPressed: _handleLogin,
                      ),
                    ],
                  ),
                ),
              ],

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
    );
  }
}
