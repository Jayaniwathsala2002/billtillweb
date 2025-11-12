// lib/widgets/navbar.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class Navbar extends StatefulWidget {
  final Function(int) onItemSelected;
  final int activeIndex;
  final Function(String)? onLanguageSelected; // Callback for language change

  const Navbar({
    Key? key,
    required this.onItemSelected,
    required this.activeIndex,
    this.onLanguageSelected,
  }) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> with TickerProviderStateMixin {
  bool _isMenuOpen = false;
  Timer? _debounceTimer;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _openInvoiceGenerator() async {
    final Uri url = Uri.parse('/webinvoice/index.html');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to open invoice generator.')),
      );
    }
  }

  void _handleNavTap(int index) {
    if (_debounceTimer?.isActive ?? false) return;
    _debounceTimer = Timer(const Duration(seconds: 1), () {});
    widget.onItemSelected(index);
    if (mounted) setState(() {});
  }

  void _toggleMenu() {
    if (_isMenuOpen) {
      _animationController.reverse().then((_) {
        if (mounted) {
          setState(() {
            _isMenuOpen = false;
          });
        }
      });
    } else {
      setState(() {
        _isMenuOpen = true;
      });
      _animationController.forward();
    }
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
        // Full-width navbar background
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF0B0655).withAlpha((0.827 * 255).round()),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 992) {
                  // Desktop layout
                  return Row(
                    children: [
                      Image.asset(
                        'assets/images/hero/logo.png',
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          _buildDesktopNavItem('Home', 0, navItemStyle),
                          const SizedBox(width: 40),
                          _buildDesktopNavItem('Features', 1, navItemStyle),
                          const SizedBox(width: 40),
                          _buildDesktopNavItem('Pricing', 2, navItemStyle),
                          const SizedBox(width: 40),
                          _buildDesktopNavItem('Partners', 3, navItemStyle),
                          const SizedBox(width: 40),
                          _buildDesktopNavItem('Business', 4, navItemStyle),
                          const SizedBox(width: 40),
                          _buildDesktopNavItem('About', 5, navItemStyle),
                          const SizedBox(width: 40),
                          _buildDesktopNavItem('Contact', 6, navItemStyle),
                          const SizedBox(width: 40),
                          ElevatedButton(
                            onPressed: _openInvoiceGenerator,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF43B9FE),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              elevation: 0,
                            ),
                            child: Text('FREE INVOICE GENERATOR',
                                style: buttonTextStyle),
                          ),
                          const SizedBox(width: 16),
                          // Language selector icon (desktop)
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.language,
                                color: Colors.white, size: 24),
                            onSelected: widget
                                .onLanguageSelected, // Passes 'English', 'Sinhala', 'Tamil'
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                  value: 'English', child: Text('English')),
                              PopupMenuItem(
                                  value: 'Sinhala', child: Text('සිංහල')),
                              PopupMenuItem(
                                  value: 'Tamil', child: Text('தமிழ்')),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  // Mobile layout
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/hero/logo.png',
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      IconButton(
                        icon: const Icon(Icons.menu,
                            color: Colors.white, size: 32),
                        onPressed: _toggleMenu,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),

        // Mobile overlay
        if (_isMenuOpen && isMobile)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleMenu,
              child: Container(
                color: Colors.black.withAlpha((0.6 * 255).round()),
              ),
            ),
          ),

        // Mobile right-side menu
        if (_isMenuOpen && isMobile)
          Align(
            alignment: Alignment.centerRight,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                constraints: const BoxConstraints(maxWidth: 300),
                height: MediaQuery.of(context).size.height,
                color: const Color(0xFF0B0655),
                child: _buildMobileMenu(navItemStyle, context),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDesktopNavItem(String label, int index, TextStyle style) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _handleNavTap(index),
        child: Text(label, style: style),
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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Language icon on FAR LEFT, Close on FAR RIGHT
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PopupMenuButton<String>(
                  icon:
                      const Icon(Icons.language, color: Colors.white, size: 24),
                  onSelected: (String value) {
                    _toggleMenu();
                    widget.onLanguageSelected?.call(value);
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'English', child: Text('English')),
                    PopupMenuItem(value: 'Sinhala', child: Text('සිංහල')),
                    PopupMenuItem(value: 'Tamil', child: Text('தமிழ்')),
                  ],
                ),
                IconButton(
                  onPressed: _toggleMenu,
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(labels.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          _toggleMenu();
                          _handleNavTap(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            labels[index],
                            style: baseStyle.copyWith(fontSize: 18),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
