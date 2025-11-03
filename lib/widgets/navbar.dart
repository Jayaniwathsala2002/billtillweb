// lib/widgets/navbar.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _openInvoiceGenerator() async {
    final Uri url = Uri.parse('/webinvoice/index.html');
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to open invoice generator.')),
      );
    }
  }

  void _closeMobileMenu() {
    if (!mounted) return;
    setState(() => _isMenuOpen = false);
  }

  void _handleNavTap(int index) {
    _closeMobileMenu();
    widget.onItemSelected(index);
  }

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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: const BoxDecoration(
            color: Color(0xD30B0655),
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
                      onPressed: _openInvoiceGenerator,
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
                      child: Text('FREE INVOICE GENERATOR',
                          style: buttonTextStyle),
                    ),
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ❌ Image.asset is NOT const → remove 'const'
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
              onTap: _closeMobileMenu,
              child: Container(
                color: const Color.fromRGBO(0, 0, 0, 0.6),
              ),
            ),
          ),

        // Mobile menu
        if (_isMenuOpen && isMobile)
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  80 -
                  MediaQuery.of(context).padding.top,
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
        onTap: () => _handleNavTap(index),
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
    final isVerySmall = MediaQuery.of(context).size.height < 650;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12, right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: _closeMobileMenu,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(255, 255, 255, 0.2),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
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
                          onTap: () => _handleNavTap(index),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: isVerySmall ? 12 : 16,
                            ),
                            child: Text(
                              labels[index],
                              style: baseStyle.copyWith(
                                fontSize: isVerySmall ? 16 : 18,
                                color: isActive
                                    ? const Color(0xFF43B9FE)
                                    : Colors.white,
                                fontWeight: isActive
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 2,
                          width: double.infinity,
                          color: isActive
                              ? const Color(0xFF43B9FE)
                              : const Color.fromRGBO(255, 255, 255, 0.2),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
