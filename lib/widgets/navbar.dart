// lib/widgets/navbar.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatefulWidget {
  final Function(int) onItemSelected;
  final int activeIndex;

  const Navbar({
    Key? key,
    required this.onItemSelected,
    required this.activeIndex,
  }) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final navItemStyle = GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    final buttonTextStyle = GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    final bool isMobile = MediaQuery.of(context).size.width < 992;

    return Stack(
      children: [
        // Main Navbar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF0B0655).withAlpha((0.827 * 255).round()),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Desktop layout
              if (constraints.maxWidth >= 992) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/hero/logo.png',
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 132),
                    Row(
                      children: [
                        _buildDesktopNavItem('Home', 0, navItemStyle),
                        const SizedBox(width: 50),
                        _buildDesktopNavItem('Features', 1, navItemStyle),
                        const SizedBox(width: 50),
                        _buildDesktopNavItem('Pricing', 2, navItemStyle),
                        const SizedBox(width: 50),
                        _buildDesktopNavItem('Partners', 3, navItemStyle),
                        const SizedBox(width: 50),
                        _buildDesktopNavItem('Business', 4, navItemStyle),
                        const SizedBox(width: 50),
                        _buildDesktopNavItem('About', 5, navItemStyle),
                        const SizedBox(width: 50),
                        _buildDesktopNavItem('Contact', 6, navItemStyle),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Open invoice generator (desktop)
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF43B9FE),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 18,
                        ),
                        elevation: 0,
                      ),
                      child: Text('FREE INVOICE GENERATOR', style: buttonTextStyle),
                    ),
                  ],
                );
              }
              // Mobile layout: hamburger/close in navbar
              else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/hero/logo.png',
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    IconButton(
                      icon: _isMenuOpen
                          ? const Icon(Icons.close, color: Colors.white, size: 32)
                          : const Icon(Icons.menu, color: Colors.white, size: 32),
                      onPressed: () => setState(() => _isMenuOpen = !_isMenuOpen),
                    ),
                  ],
                );
              }
            },
          ),
        ),

        // Mobile overlay
        if (_isMenuOpen && isMobile)
          Positioned.fill(
            child: GestureDetector(
              onTap: () => setState(() => _isMenuOpen = false),
              child: Container(
                color: Colors.black.withAlpha((0.6 * 255).round()),
              ),
            ),
          ),

        // Mobile full-screen menu (NO close button inside)
        if (_isMenuOpen && isMobile)
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 80),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                color: Color(0xFF0B0655),
              ),
              child: _buildMobileMenu(navItemStyle),
            ),
          ),
      ],
    );
  }

  Widget _buildDesktopNavItem(String label, int index, TextStyle style) {
    final isActive = widget.activeIndex == index;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onItemSelected(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: style.copyWith(
                color: isActive ? const Color(0xFF43B9FE) : Colors.white,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: isActive ? 24 : 0,
              color: const Color(0xFF43B9FE),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenu(TextStyle baseStyle) {
    final labels = [
      'Home',
      'Features',
      'Pricing',
      'Partners',
      'Business',
      'About',
      'Contact'
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ❌ Removed close button from here

            ...List.generate(labels.length, (index) {
              final isActive = widget.activeIndex == index;
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() => _isMenuOpen = false);
                      widget.onItemSelected(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        labels[index],
                        style: baseStyle.copyWith(
                          fontSize: 18,
                          color: isActive ? const Color(0xFF43B9FE) : Colors.white,
                          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  if (isActive)
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: const Color(0xFF43B9FE),
                    )
                  else
                    Container(
                      height: 0.5,
                      width: double.infinity,
                      color: Colors.white.withAlpha((0.2 * 255).round()),
                    ),
                ],
              );
            }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}