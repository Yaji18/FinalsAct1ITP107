import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/cozy_background.dart';

// Simple data model para sa bawat menu item
class _MenuItem {
  final String name;
  final String price;
  final String image;
  const _MenuItem(this.name, this.price, this.image);
}

const List<_MenuItem> _menuItems = [
  _MenuItem('Avocado Toast w/ Egg', '5.00', 'assets/images/avocado_toast.jpg'),
  _MenuItem('Matcha Latte', '4.50', 'assets/images/matcha_latte.jpg'),
  _MenuItem('Cheesecake', '2.50', 'assets/images/cheesecake.jpg'),
  _MenuItem('Hot Latte', '5.00', 'assets/images/hot_latte.jpg'),
  _MenuItem('Iced Latte', '4.00', 'assets/images/iced_latte.jpg'),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Kinukuha yung name/username na ipinasa via route arguments
    // galing Sign-Up (buong pangalan) o Login (username)
    final args = ModalRoute.of(context)?.settings.arguments;
    final String displayName =
        (args is String && args.trim().isNotEmpty) ? args.trim() : 'friend';

    return Scaffold(
      body: CozyBackground(
        child: SafeArea(
        child: Column(
          children: [
            // Header: welcome message + logout button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Welcome,\n$displayName',
                      style: const TextStyle(
                        color: AppColors.textDark,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      foregroundColor: AppColors.accentDark,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    onPressed: () {
                      // Buburahin ang buong navigation stack pabalik sa
                      // Login — hindi na mababalikan ang Home gamit ang back
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // Menu list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        // Icon avatar (stand-in for a food photo)
                                              ClipOval(
                          child: Image.asset(
                            item.image,
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 22),

                        // Name
                        Expanded(
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              color: AppColors.textDark,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                                               // Price tag — clickable, magpapakita ng purchase confirmation
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${item.name} purchased successfully!'),
                                backgroundColor: AppColors.accentDark,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              '\$${item.price}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}