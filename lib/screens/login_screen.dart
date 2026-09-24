import 'package:flutter/material.dart';
import '../widgets/matrix_rain_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // GlobalKey para sa Form — ito ang gagamitin natin para i-validate
  // lahat ng fields bago mag-navigate
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    // Laging i-dispose ang controllers para maiwasan ang memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Validate muna bago mag-proceed — kung may empty field, hindi tuloy
    if (_formKey.currentState!.validate()) {
      // pushReplacementNamed = pinapalitan ang Login screen sa stack
      // (hindi na babalikan pag pinindot ang back button — tama ito para
      // sa login, kasi ayaw natin bumalik sa login screen after mag-login)
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
      body: MatrixRainBackground(
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
                    // App logo / title area
                    const Icon(
                      Icons.lock_outline,
                      color: Color(0xFF00FF41),
                      size: 60,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'LOGIN TO MATRIX',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF00FF41),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '> welcome back, user',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF00FF41).withOpacity(0.6),
                        fontSize: 14,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Card container para mas readable yung form kahit
                    // may animated background
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.65),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF00FF41).withOpacity(0.4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Email / username field
                          TextFormField(
                            controller: _emailController,
                            style: const TextStyle(color: Color(0xFF00FF41)),
                            decoration: const InputDecoration(
                              labelText: 'Email / Username',
                              prefixIcon:
                                  Icon(Icons.person, color: Color(0xFF00FF41)),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your email or username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Password field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: const TextStyle(color: Color(0xFF00FF41)),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color(0xFF00FF41)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: const Color(0xFF00FF41),
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
                          const SizedBox(height: 24),

                          // Login button — navigates to Home screen
                          ElevatedButton(
                            onPressed: _handleLogin,
                            child: const Text('LOGIN'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Link papunta sa Sign-Up screen
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: const Color(0xFF00FF41).withOpacity(0.7),
                            fontFamily: 'monospace',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // pushNamed = idinadagdag lang sa stack, kaya
                            // pwede pa ring bumalik gamit ang back/pop
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF00FF41),
                              fontWeight: FontWeight.bold,
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
