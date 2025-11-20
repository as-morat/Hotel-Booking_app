import 'package:booking_app/services/widgets_supported.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                child: Column(
                  children: [
                    _textField(
                      Icons.email_outlined,
                      "Email",
                      false,
                      TextInputType.emailAddress,
                    ),
                    _textField(
                      Icons.person_outlined,
                      "Username",
                      false,
                      TextInputType.name,
                    ),
                    _textField(
                      Icons.password,
                      "Password",
                      true,
                      TextInputType.visiblePassword,
                    ),
                    _textField(
                      Icons.password,
                      "Confirm Password",
                      true,
                      TextInputType.visiblePassword,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 55,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF90CAF9),
                      Color(0xFF42A5F5),
                      Color(0xFF1E88E5),
                    ],
                    stops: [0.0, 0.45, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 6),
                      blurRadius: 12,
                      spreadRadius: 1,
                      color: Colors.blue.withValues(alpha: 0.25),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: .zero,
                  ),
                  child: const Text(
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    "Already have an account?",
                    style: AppWidget.normalTextStyle(
                      14,
                    ).copyWith(color: Colors.black54),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: .zero,
                      splashFactory: NoSplash.splashFactory,
                      overlayColor: Colors.transparent,
                    ),
                    child: Text(
                      "Log In",
                      style: AppWidget.normalTextStyle(
                        17,
                      ).copyWith(color: theme.colorScheme.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(child: Divider(thickness: 2)),
                  Padding(
                    padding: .all(12),
                    child: Text(
                      "Or continue with",
                      style: AppWidget.normalTextStyle(
                        15,
                      ).copyWith(color: Colors.black54),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 2)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: .center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset("images/google.png"),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  SizedBox(
                    height: 52,
                    width: 52,
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset("images/facebook.png"),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  SizedBox(
                    height: 44,
                    width: 44,
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset("images/twitter.png"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(
    IconData icon,
    String hintText, [
    bool obscureText = false,
    TextInputType type = TextInputType.none,
  ]) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      height: 58,
      width: size.width,
      margin: const .only(bottom: 18),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: type,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: InputBorder.none,
          prefixIcon: Icon(icon, size: 24, color: theme.colorScheme.primary),
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
}
