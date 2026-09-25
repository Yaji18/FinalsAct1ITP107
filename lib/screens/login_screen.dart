import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/cozy_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // pushReplacementNamed — pinapalitan ang Login sa stack, hindi na
      // babalikan ng back button pagkatapos mag-login
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: _emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CozyBackground(
        child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Decorative avatar circle sa itaas
                  Center(
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surface,
                        border: Border.all(
                          color: AppColors.accent.withValues(alpha: 0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accentDark.withValues(alpha: 0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/login_icon.jpg',
                                width: 140,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title — cozy script-style heading
                  const Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Username / email field
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(color: AppColors.textDark),
                    decoration: const InputDecoration(
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person_outline,
                          color: AppColors.accentDark),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: const TextStyle(color: AppColors.textDark),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: AppColors.accentDark),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.accentDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 28),

                  // Login button
                  ElevatedButton(
                    onPressed: _handleLogin,
                    child: const Text('Sign In'),
                  ),
                  const SizedBox(height: 18),

                  // Link papunta sa Sign-Up
                  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      "Don't have an account? ",
      style: TextStyle(
        color: AppColors.textDark.withValues(alpha: 0.75),
        fontSize: 14,
      ),
    ),
    GestureDetector(
      onTap: () {
        // pushNamed — pwede pa ring bumalik gamit ang pop
        Navigator.pushNamed(context, '/signup');
      },
      child: const Text(
        'Sign Up',
        style: TextStyle(
          color: AppColors.accentDark,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
  ],
),
                ],
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }
}