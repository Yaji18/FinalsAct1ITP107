import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                        style: GoogleFonts.playfairDisplay(
                          color: AppColors.textDark,
                          fontSize: 26,
                          fontStyle: FontStyle.italic,
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
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          (route) => false,
                        );
                      },
                      child: Text(
                        'Logout',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
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
                          // Food/drink photo
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
                              style: GoogleFonts.poppins(
                                color: AppColors.textDark,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
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
                                    '${item.name} purchased successfully!',
                                    style: GoogleFonts.poppins(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
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
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
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