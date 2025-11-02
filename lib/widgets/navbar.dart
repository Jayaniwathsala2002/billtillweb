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
                        // Open invoice generator
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
                      child: Text(
                        'FREE INVOICE GENERATOR',
                        style: buttonTextStyle,
                      ),
                    ),
                  ],
                );
              } else {
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
                          ? const Icon(Icons.close,
                              color: Colors.white, size: 32)
                          : const Icon(Icons.menu,
                              color: Colors.white, size: 32),
                      onPressed: () =>
                          setState(() => _isMenuOpen = !_isMenuOpen),
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

        // ✅ FIXED: Mobile menu with safe height & scroll
        if (_isMenuOpen && isMobile)
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  80 - // space for navbar
                  MediaQuery.of(context)
                      .padding
                      .top, // status bar (on mobile/web)
              child: Container(
                color: const Color(0xFF0B0655),
                child: _buildMobileMenu(navItemStyle, context),
              ),
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
        onTap: () {
          widget.onItemSelected(index);
          if (mounted) setState(() {});
        },
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

  // ✅ Accept context to read viewport size
  Widget _buildMobileMenu(TextStyle baseStyle, BuildContext context) {
    final labels = [
      'Home',
      'Features',
      'Pricing',
      'Partners',
      'Business',
      'About',
      'Contact'
    ];

    // Detect very small viewports (e.g., laptop window < 650px tall)
    final isVerySmall = MediaQuery.of(context).size.height < 650;

    return Padding(
      padding: EdgeInsets.only(
        top: isVerySmall ? 12 : 20,
        left: 24,
        right: 24,
        bottom: isVerySmall ? 20 : 40,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      padding: EdgeInsets.symmetric(
                        vertical: isVerySmall ? 12 : 16,
                      ),
                      child: Text(
                        labels[index],
                        style: baseStyle.copyWith(
                          fontSize: isVerySmall ? 16 : 18,
                          color:
                              isActive ? const Color(0xFF43B9FE) : Colors.white,
                          fontWeight:
                              isActive ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: isActive
                        ? const Color(0xFF43B9FE)
                        : Colors.white.withAlpha((0.2 * 255).round()),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
