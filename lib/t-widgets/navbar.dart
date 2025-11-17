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
    final Uri url = Uri.parse('https://billtillweb.vercel.app/web/index.html');

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

  // Function to show confirmation dialog before changing language
  Future<void> _confirmLanguageChange(String language) async {
    String displayLanguage = language;
    if (language == 'Sinhala') {
      displayLanguage = 'සිංහල';
    } else if (language == 'Tamil') {
      displayLanguage = 'தமிழ்';
    }

    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0053C0), // Changed to #0053C0
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Text(
            'Confirm Language Change',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          content: Text(
            'Are you sure you want to select $displayLanguage?',
            style: GoogleFonts.poppins(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User cancelled
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                    color: Colors.white), // Changed to white
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed
              },
              child: Text(
                'OK',
                style: GoogleFonts.poppins(
                    color: Colors.white), // Changed to white
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      // Call the parent's language selection callback if confirmed
      if (mounted) {
        widget.onLanguageSelected?.call(language);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final navItemStyle = GoogleFonts.poppins(
      color: Colors.white,
      fontSize: _getNavItemFontSize(screenWidth),
      fontWeight: FontWeight.w500,
    );

    final buttonTextStyle = GoogleFonts.poppins(
      color: Colors.white,
      fontSize: _getButtonFontSize(screenWidth),
      fontWeight: FontWeight.bold,
    );

    final bool isMobile = screenWidth < 992;
    final bool isTablet = screenWidth >= 992 && screenWidth < 1200;

    return Stack(
      children: [
        // Full-width navbar background
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: _getHorizontalPadding(screenWidth),
            vertical: 16,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF170069), Color(0xFF0053C0)],
            ),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (!isMobile) {
                  // Desktop/Tablet layout
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _handleNavTap(0); // Navigate to home page
                        },
                        child: Image.asset(
                          'assets/images/hero/logo.png',
                          height: _getLogoHeight(screenWidth),
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Spacer(),
                      if (isTablet)
                        _buildTabletNavBar(navItemStyle, buttonTextStyle)
                      else
                        _buildDesktopNavBar(navItemStyle, buttonTextStyle),
                    ],
                  );
                } else {
                  // Mobile layout
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _handleNavTap(0); // Navigate to home page
                        },
                        child: Image.asset(
                          'assets/images/hero/logo.png',
                          height: 50,
                          fit: BoxFit.contain,
                        ),
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
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF170069), Color(0xFF0053C0)],
                  ),
                ),
                child: _buildMobileMenu(navItemStyle, context),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDesktopNavBar(
      TextStyle navItemStyle, TextStyle buttonTextStyle) {
    return Row(
      children: [
        _buildDesktopNavItem('முகப்பு', 0, navItemStyle),
        const SizedBox(width: 32),
        _buildDesktopNavItem('அம்சங்கள்', 1, navItemStyle),
        const SizedBox(width: 32),
        _buildDesktopNavItem('விலைகள்', 2, navItemStyle),
        const SizedBox(width: 32),
        _buildDesktopNavItem('கூட்டாளர்கள்', 3, navItemStyle),
        const SizedBox(width: 32),
        _buildDesktopNavItem('வியாபாரம்', 4, navItemStyle),
        const SizedBox(width: 32),
        _buildDesktopNavItem('மேலும் தகவல்', 5, navItemStyle),
        const SizedBox(width: 32),
        _buildDesktopNavItem('விசாரணைகள்', 6, navItemStyle),
        const SizedBox(width: 32),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF170069), Color(0xFF0053C0)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton(
            onPressed: _openInvoiceGenerator,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Text('விலைப்பட்டியல் பெறுதல்', style: buttonTextStyle),
          ),
        ),
        const SizedBox(width: 16),
        // Language selector icon (desktop)
        PopupMenuButton<String>(
          icon: const Icon(Icons.language, color: Colors.white, size: 24),
          onSelected: _confirmLanguageChange,
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'English', child: Text('English')),
            PopupMenuItem(value: 'Sinhala', child: Text('සිංහල')),
            PopupMenuItem(value: 'Tamil', child: Text('தமிழ்')),
          ],
        ),
      ],
    );
  }

  Widget _buildTabletNavBar(TextStyle navItemStyle, TextStyle buttonTextStyle) {
    return Row(
      children: [
        // Reduced spacing for tablet
        _buildDesktopNavItem('முகப்பு', 0, navItemStyle),
        const SizedBox(width: 20),
        _buildDesktopNavItem('அம்சங்கள்', 1, navItemStyle),
        const SizedBox(width: 20),
        _buildDesktopNavItem('விலைகள்', 2, navItemStyle),
        const SizedBox(width: 20),
        _buildDesktopNavItem('கூட்டாளர்கள்', 3, navItemStyle),
        const SizedBox(width: 20),

        // More important items remain visible
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.white, size: 24),
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'வியாபாரம்', child: Text('வியாபாரம்')),
            const PopupMenuItem(
                value: 'மேலும் தகவல்', child: Text('மேலும் தகவல்')),
            const PopupMenuItem(value: 'விசாரணைகள்', child: Text('விசாரணைகள்')),
          ],
          onSelected: (value) {
            // Handle the selected menu item
            final index =
                ['வியாபாரம்', 'மேலும் தகவல்', 'விசாரணைகள்'].indexOf(value);
            if (index != -1) {
              _handleNavTap(index + 4); // Adjust index accordingly
            }
          },
        ),
        const SizedBox(width: 16),

        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF170069), Color(0xFF0053C0)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton(
            onPressed: _openInvoiceGenerator,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Text('விலைப்பட்டியல்', style: buttonTextStyle),
          ),
        ),
        const SizedBox(width: 12),

        // Language selector icon (tablet)
        PopupMenuButton<String>(
          icon: const Icon(Icons.language, color: Colors.white, size: 22),
          onSelected: _confirmLanguageChange,
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'English', child: Text('English')),
            PopupMenuItem(value: 'Sinhala', child: Text('සිංහල')),
            PopupMenuItem(value: 'Tamil', child: Text('தமிழ்')),
          ],
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
      'முகப்பு',
      'அம்சங்கள்',
      'விலைகள் ',
      'கூட்டாளர்கள்',
      'வியாபாரம்',
      'மேலும் தகவல்',
      'விசாரணைகள்'
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language icon on FAR LEFT, Close on FAR RIGHT
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PopupMenuButton<String>(
                  icon:
                      const Icon(Icons.language, color: Colors.white, size: 24),
                  onSelected: (String value) {
                    _toggleMenu();
                    _confirmLanguageChange(value);
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

  // Helper methods for responsive design
  double _getNavItemFontSize(double screenWidth) {
    if (screenWidth < 992) return 16;
    if (screenWidth < 1200) return 14; // Smaller font for tablets
    return 16; // Normal font for large screens
  }

  double _getButtonFontSize(double screenWidth) {
    if (screenWidth < 992) return 16;
    if (screenWidth < 1200) return 13; // Smaller font for tablets
    return 16; // Normal font for large screens
  }

  double _getHorizontalPadding(double screenWidth) {
    if (screenWidth < 768) return 16;
    if (screenWidth < 1200) return 20; // Less padding for tablets
    return 20; // Normal padding for large screens
  }

  double _getLogoHeight(double screenWidth) {
    if (screenWidth < 992) return 50;
    if (screenWidth < 1200) return 55; // Slightly smaller for tablets
    return 60; // Normal size for large screens
  }
}
