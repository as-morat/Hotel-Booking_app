import 'package:booking_app/pages/sign_up.dart';
import 'package:booking_app/services/widgets_supported.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                  borderRadius: .circular(40),
                ),
                child: Text(
                  "Welcome Back",
                  style: AppWidget.normalTextStyle(18).copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 120,
                width: 240,
                padding: const .symmetric(vertical: 12),
                alignment: .topLeft,
                child: Text(
                  "Log in to your account",
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
                      padding: 18,
                      obscureText: false,
                      type: TextInputType.emailAddress,
                    ),
                    _textField(
                      controller: _passwordController,
                      icon: Icons.lock_outline,
                      hintText: "Password",
                      padding: 2,
                      obscureText: !_isPasswordVisible,
                      type: TextInputType.visiblePassword,
                      isPassword: true,
                    ),
                    Align(
                      alignment: .topRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          elevation: 0,
                          splashFactory: NoSplash.splashFactory,
                          overlayColor: Colors.transparent,
                        ),
                        child: const Text("Forgot Password?"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 55,
                width: size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Login logic here
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: .circular(16)),
                    shadowColor: Colors.blue.withValues(alpha: 0.25),
                  ),
                  child: Ink(
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
                      borderRadius: .circular(16),
                    ),
                    child: Container(
                      alignment: .center,
                      child: const Text(
                        "Log In",
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
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppWidget.normalTextStyle(
                      14,
                    ).copyWith(color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUp()),
                    ),
                    child: Text(
                      "Sign Up",
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
    required double padding,
    bool obscureText = false,
    TextInputType type = TextInputType.none,
    bool isPassword = false,
  }) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      height: 58,
      width: size.width,
      margin: .only(bottom: padding),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: .circular(16),
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
          return null;
        },
        decoration: InputDecoration(
          contentPadding: const .symmetric(vertical: 14),
          border: InputBorder.none,
          prefixIcon: Icon(icon, size: 24, color: theme.colorScheme.primary),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
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
      child: IconButton(
        onPressed: () {
          // Social login logic
        },
        icon: Image.asset(imagePath),
      ),
    );
  }
}
