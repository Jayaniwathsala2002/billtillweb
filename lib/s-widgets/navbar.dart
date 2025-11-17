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
                if (constraints.maxWidth >= 992) {
                  // Desktop layout
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _handleNavTap(0); // Navigate to home page
                        },
                        child: Image.asset(
                          'assets/images/hero/logo.png',
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          _buildDesktopNavItem(
                              'ප්‍රධාන පිටුව', 0, navItemStyle),
                          const SizedBox(width: 40),
                          _buildDesktopNavItem('විශේෂාංග', 1, navItemStyle),
                          const SizedBox(width: 40),
                          _buildDesktopNavItem('මිලයන්', 2, navItemStyle),
                          const SizedBox(width: 40),
                          _buildDesktopNavItem('සහකරුවන්', 3, navItemStyle),
                          const SizedBox(width: 40),
                          _buildDesktopNavItem('ව්‍යාපාර', 4, navItemStyle),
                          const SizedBox(width: 40),
                          _buildDesktopNavItem(
                              'වැඩිදුර විස්තර', 5, navItemStyle),
                          const SizedBox(width: 40),
                          _buildDesktopNavItem('විමසීම්', 6, navItemStyle),
                          const SizedBox(width: 40),
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
                              child: Text('ඉන්වොයිස් පත්‍රයක් ලබාගැනීම​',
                                  style: buttonTextStyle),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Language selector icon (desktop)
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.language,
                                color: Colors.white, size: 24),
                            onSelected:
                                _confirmLanguageChange, // Use the confirmation function
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
      'ප්‍රධාන පිටුව',
      'විශේෂාංග',
      'මිලයන්',
      'සහකරුවන්',
      'ව්‍යාපාර',
      'වැඩිදුර විස්තර',
      'විමසීම්'
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
                    _confirmLanguageChange(
                        value); // Use the confirmation function
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
