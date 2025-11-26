import 'package:booking_app/pages/auth/sign_in.dart';
import 'package:booking_app/services/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/custom_snackbar.dart';
import 'auth_provider/auth_controller.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final _formKey = GlobalKey<FormState>();
  AuthController get _auth => ref.read(authControllerProvider);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _formKey.currentState?.save();

    setState(() => _isLoading = true);
    try {
      await _auth.signUp(
        _emailController.text.trim(),
        _confirmPasswordController.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        showCustomSnackBar(
          context,
          'Sign up successfully!',
          icon: Icons.check_circle_outline,
          color: Colors.green,
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        showCustomSnackBar(
          context,
          e.toString(),
          icon: Icons.cancel_outlined,
          color: Colors.red,
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _googleSubmit() async {
    setState(() => _isLoading = true);
    try {
      await _auth.googleSignIn();
      if (mounted) {
        showCustomSnackBar(
          context,
          'Sign up successfully!',
          icon: Icons.check_circle_outline,
          color: Colors.greenAccent,
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        showCustomSnackBar(
          context,
          e.toString(),
          icon: Icons.cancel_outlined,
          color: Colors.red,
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const .fromLTRB(20, 60, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              Container(
                height: 55,
                width: 150,
                alignment: .center,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(
                    alpha: 0.45,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  "Join us today",
                  style: AppWidget.normalTextStyle(18).copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 120,
                width: 220,
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: .topLeft,
                child: Text(
                  "Create your account",
                  style: AppWidget.normalTextStyle(
                    36,
                  ).copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _textField(
                      controller: _emailController,
                      icon: Icons.email_outlined,
                      hintText: "Email",
                      obscureText: false,
                      type: TextInputType.emailAddress,
                    ),
                    _textField(
                      controller: _passwordController,
                      icon: Icons.lock_outline,
                      hintText: "Password",
                      obscureText: !_isPasswordVisible,
                      type: TextInputType.visiblePassword,
                      isPassword: true,
                      onVisibilityToggle: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    _textField(
                      controller: _confirmPasswordController,
                      icon: Icons.lock_outline,
                      hintText: "Confirm Password",
                      obscureText: !_isConfirmPasswordVisible,
                      type: TextInputType.visiblePassword,
                      isPassword: true,
                      isConfirmPassword: true,
                      onVisibilityToggle: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 55,
                width: size.width,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadowColor: Colors.blue.withValues(alpha: 0.25),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: .topLeft,
                        end: .bottomRight,
                        colors: [
                          Color(0xFF90CAF9),
                          Color(0xFF42A5F5),
                          Color(0xFF1E88E5),
                        ],
                        stops: [0.0, 0.45, 1.0],
                      ),
                      borderRadius: .circular(12),
                    ),
                    alignment: .center,
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          )
                        : const Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: AppWidget.normalTextStyle(
                      14,
                    ).copyWith(color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignIn()),
                    ),
                    child: Text(
                      "Log In",
                      style: AppWidget.normalTextStyle(17).copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 2)),
                  Padding(
                    padding: const .all(12),
                    child: Text(
                      "Or continue with",
                      style: AppWidget.normalTextStyle(
                        15,
                      ).copyWith(color: Colors.black54),
                    ),
                  ),
                  const Expanded(child: Divider(thickness: 2)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: .center,
                children: [
                  _socialButton("images/google.png", 50),
                  const SizedBox(width: 10),
                  _socialButton("images/facebook.png", 52),
                  const SizedBox(width: 10),
                  _socialButton("images/twitter.png", 44),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    bool obscureText = false,
    TextInputType type = TextInputType.none,
    bool isPassword = false,
    bool isConfirmPassword = false,
    VoidCallback? onVisibilityToggle,
  }) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      height: 60,
      width: size.width,
      margin: const .only(bottom: 18),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: .circular(12),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: type,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $hintText';
          }
          if (hintText == "Email" && !value.contains('@')) {
            return 'Please enter a valid email';
          }
          if (hintText == "Password" && value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          if (isConfirmPassword && value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: const .symmetric(vertical: 14),
          border: InputBorder.none,
          prefixIcon: Icon(icon, size: 24, color: theme.colorScheme.primary),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: onVisibilityToggle,
                )
              : null,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          errorStyle: const TextStyle(height: 0.2),
          floatingLabelBehavior: .never,
        ),
        style: TextStyle(
          color: theme.colorScheme.tertiary,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _socialButton(String imagePath, double size) {
    return SizedBox(
      height: size,
      width: size,
      child: IconButton(onPressed: _googleSubmit, icon: Image.asset(imagePath)),
    );
  }
}
