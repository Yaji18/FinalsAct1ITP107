import 'package:flutter/material.dart';
import '../widgets/matrix_rain_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Kinukuha natin dito yung argument na ipinasa papunta sa route na 'to.
    // Galing ito sa Sign-Up screen (buong pangalan) o sa Login screen
    // (email/username), depende kung saan nanggaling ang user.
    final args = ModalRoute.of(context)?.settings.arguments;
    final String displayName =
        (args is String && args.trim().isNotEmpty) ? args.trim() : 'User';

    return Scaffold(
      body: MatrixRainBackground(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF00FF41).withOpacity(0.4),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Color(0xFF00FF41),
                          size: 56,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '> access granted',
                          style: TextStyle(
                            color: const Color(0xFF00FF41).withOpacity(0.6),
                            fontSize: 14,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Welcome message — dito ipinapakita yung name na
                        // ipinasa via route arguments
                        Text(
                          'Welcome, $displayName!',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF00FF41),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'You have successfully entered the Matrix.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF00FF41).withOpacity(0.7),
                            fontSize: 14,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Logout button — navigates back to Login screen
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // pushReplacementNamed papunta ulit sa Login,
                              // at buburahin nito lahat ng naunang routes sa
                              // stack (Home, Sign-Up) gamit ang predicate na
                              // "(route) => false" — para hindi na mabalikan
                              // ang Home screen gamit ang back button pagkatapos
                              // mag-logout.
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/login',
                                (route) => false,
                              );
                            },
                            icon: const Icon(Icons.logout),
                            label: const Text('LOGOUT'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
