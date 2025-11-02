import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class BusinessSection extends StatefulWidget {
  const BusinessSection({Key? key}) : super(key: key);

  @override
  State<BusinessSection> createState() => _BusinessSectionState();
}

class _BusinessSectionState extends State<BusinessSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _containerColorAnimation;
  int? _selectedCardIndex;
  Timer? _resetTimer;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _containerColorAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void _onCardSelected(int index) {
    _resetTimer?.cancel();

    setState(() {
      if (_selectedCardIndex == index) {
        // toggle off
        _selectedCardIndex = null;
        _animationController.reverse();
      } else {
        _selectedCardIndex = index;
        _animationController.forward();

        // auto-reset after 3 seconds only if newly selected
        _resetTimer = Timer(const Duration(seconds: 3), () {
          if (!mounted) return;
          setState(() {
            _selectedCardIndex = null;
            _animationController.reverse();
          });
          _resetTimer = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _resetTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;
    final isTablet = screenWidth > 600 && screenWidth <= 1024;

    return SingleChildScrollView(
      child: AnimatedBuilder(
        animation: _containerColorAnimation,
        builder: (context, child) {
          final bgColor = _selectedCardIndex != null
              ? Color.lerp(Colors.white, Colors.blue.shade50,
                  _containerColorAnimation.value)
              : Colors.white;

          return Container(
            width: double.infinity,
            color: bgColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Main Content
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 32 : 60,
                    horizontal: isMobile ? 16 : 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Industry-Specific Solutions',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 26 : (isTablet ? 32 : 38),
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isMobile ? 8 : 12),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: isMobile ? 8 : 32),
                        child: Text(
                          'Comprehensive billing solutions designed for your specific industry needs',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
                            color: Colors.grey.shade700,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: isMobile ? 32 : 60),
                      // Circular design + sections
                      _buildCircularDesignWithLine(context),
                      SizedBox(height: isMobile ? 40 : 80),
                    ],
                  ),
                ),

                // Enterprise Solutions CTA - Full width with different background
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 32 : 50,
                    horizontal: isMobile ? 20 : 32,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isMobile ? 20 : 30),
                      topRight: Radius.circular(isMobile ? 20 : 30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Need Custom Enterprise Solutions?',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 22 : (isTablet ? 26 : 32),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isMobile ? 12 : 16),
                      SizedBox(
                        width: isMobile
                            ? double.infinity
                            : (isTablet ? double.infinity : 800),
                        child: Text(
                          'Our enterprise team specializes in building customized billing solutions tailored to your specific business requirements. Whether you need multi-location management, custom reporting, or integration with existing systems, we have the expertise to deliver.',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 13 : (isTablet ? 15 : 17),
                            color: Colors.white70,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: isMobile ? 20 : 32),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Contact Enterprise Team'),
                              content: const Text(
                                  'Our enterprise team will contact you shortly to discuss custom solutions for your business.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue.shade800,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 24 : 48,
                            vertical: isMobile ? 14 : 18,
                          ),
                          textStyle: GoogleFonts.poppins(
                            fontSize: isMobile ? 14 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        child: Text(isMobile
                            ? 'Contact Team'
                            : 'Talk to Our Enterprise Team'),
                      ),
                      SizedBox(height: isMobile ? 8 : 12),
                      Text(
                        'Get a free consultation within 24 hours',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 11 : 13,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),

                // Additional Industries Section - Now with white background
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 32 : 60,
                    horizontal: isMobile ? 16 : 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 8 : 0,
                        ),
                        child: Text(
                          'More Industries We Serve',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile
                                ? 26
                                : (isTablet
                                    ? 28
                                    : 34), // ← Increased from 22 to 26
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: isMobile ? 12 : 20),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 16 : 40),
                        child: Text(
                          'Expanding our reach across diverse sectors',
                          style: GoogleFonts.poppins(
                            fontSize:
                                isMobile ? 15 : 16, // ← Increased from 13 to 15
                            color: Colors.grey.shade700,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: isMobile ? 24 : 48),

                      // Flower Industry Design
                      LargeFlowerIndustryDesign(),
                      SizedBox(height: isMobile ? 32 : 60),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCircularDesignWithLine(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;
    final isTablet = screenWidth > 600 && screenWidth <= 1024;

    if (isMobile) return _buildMobileLayout();
    if (isTablet) return _buildTabletLayout();
    return _buildDesktopLayout();
  }

  // ---------------- DESCRIPTIONS & DATA ----------------------------------
  final List<_IndustryData> _industryData = const [
    _IndustryData(
      title: 'Retail',
      description:
          'Supermarkets, clothing stores, electronics, convenience stores with inventory management, barcode scanning and POS integration for fast checkouts and accurate stock control.',
      icon: Icons.shopping_cart,
    ),
    _IndustryData(
      title: 'Restaurants',
      description:
          'Cafes, fine dining and fast food outlets with table management, kitchen order routing, menu variants, modifiers and delivery integration for improved service flow.',
      icon: Icons.restaurant,
    ),
    _IndustryData(
      title: 'Hotels',
      description:
          'Resorts, guest houses and boutique hotels with room billing, split-billing, service charges, checkout automation and guest folio management tailored for hospitality needs.',
      icon: Icons.hotel,
    ),
    _IndustryData(
      title: 'Service Centers',
      description:
          'Repair shops, salons and service providers with appointment scheduling, job cards, parts tracking, customer history and service reminders to streamline operations.',
      icon: Icons.build,
    ),
  ];

  // ---------------- LAYOUTS ----------------------------------------------
  Widget _buildDesktopLayout() {
    return SizedBox(
      height: 510,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Four Equal Sections (row)
          Positioned(
            top: 0,
            child: SizedBox(
              width: 900,
              height: 550,
              child: Row(
                children: List.generate(4, (i) {
                  final d = _industryData[i];
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: _IndustryCard(
                        title: d.title,
                        description: d.description,
                        icon: d.icon,
                        isSelected: _selectedCardIndex == i,
                        onTap: () => _onCardSelected(i),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // Horizontal Line
          Positioned(
            top: 420,
            child:
                Container(width: 900, height: 3, color: Colors.blue.shade400),
          ),

          // Central Circle Overlay
          Positioned(
            top: 420 - 90,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade800,
                border: Border.all(color: Colors.white, width: 8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade900.withOpacity(0.6),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Industry-Specific\nSolutions',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return SizedBox(
      height: 600,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              width: 700,
              height: 400,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _IndustryCard(
                              title: _industryData[0].title,
                              description: _industryData[0].description,
                              icon: _industryData[0].icon,
                              isSelected: _selectedCardIndex == 0,
                              onTap: () => _onCardSelected(0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _IndustryCard(
                              title: _industryData[1].title,
                              description: _industryData[1].description,
                              icon: _industryData[1].icon,
                              isSelected: _selectedCardIndex == 1,
                              onTap: () => _onCardSelected(1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _IndustryCard(
                              title: _industryData[2].title,
                              description: _industryData[2].description,
                              icon: _industryData[2].icon,
                              isSelected: _selectedCardIndex == 2,
                              onTap: () => _onCardSelected(2),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _IndustryCard(
                              title: _industryData[3].title,
                              description: _industryData[3].description,
                              icon: _industryData[3].icon,
                              isSelected: _selectedCardIndex == 3,
                              onTap: () => _onCardSelected(3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Line + Circle
          Positioned(
              top: 430,
              child: Container(
                  width: 700, height: 3, color: Colors.blue.shade400)),
          Positioned(
            top: 430 - 70,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade800,
                border: Border.all(color: Colors.white, width: 6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade900.withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Industry-Specific\nSolutions',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < _industryData.length; i++) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6),
            child: _IndustryCard(
              title: _industryData[i].title,
              description: _industryData[i].description,
              icon: _industryData[i].icon,
              isSelected: _selectedCardIndex == i,
              onTap: () => _onCardSelected(i),
            ),
          ),
        ],
        const SizedBox(
            height: 1), // ← Reduced to 4 (moves up by ~12 pixels from original)

        // Stack for line and overlapping circle
        SizedBox(
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Horizontal line
              Container(
                width: 280,
                height: 2,
                color: Colors.blue.shade400,
              ),
              // Medium circle overlaying the line
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade800,
                  border: Border.all(color: Colors.white, width: 6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade900.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Industry\nSolutions',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// --------------------------- SUPPORT CLASSES ----------------------------

class _IndustryData {
  final String title;
  final String description;
  final IconData icon;
  const _IndustryData({
    required this.title,
    required this.description,
    required this.icon,
  });
}

/// Card widget focused on smooth, reliable animation and description handling
class _IndustryCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _IndustryCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_IndustryCard> createState() => _IndustryCardState();
}

class _IndustryCardState extends State<_IndustryCard> {
  bool _isHovering = false;

  void _onEnter(PointerEvent _) => setState(() => _isHovering = true);
  void _onExit(PointerEvent _) => setState(() => _isHovering = false);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;
    final isTablet = screenWidth > 600 && screenWidth <= 1024;

    // Determine visual states
    final bool selected = widget.isSelected;
    final double scale = selected ? 1.04 : (_isHovering ? 1.03 : 1.0);
    final double elevation = selected ? 14 : (_isHovering ? 8 : 2);
    final Color borderColor = selected
        ? Colors.blue.shade400
        : (_isHovering ? Colors.blue.shade300 : Colors.grey.shade300);
    final double borderWidth = selected ? 2.0 : (_isHovering ? 1.5 : 1.0);
    final Color bgColor = selected ? Colors.blue.shade50 : Colors.white;
    final int maxLines = isMobile ? (selected ? 8 : 4) : (selected ? 10 : 6);
    final double cardMinHeight = isMobile ? 140 : (isTablet ? 180 : 220);

    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(scale),
          transformAlignment: Alignment.center,
          padding: EdgeInsets.all(isMobile ? 14 : 20),
          constraints: BoxConstraints(minHeight: cardMinHeight),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: borderWidth),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: elevation,
                offset: Offset(0, elevation / 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon circle + title
              Container(
                width: isMobile ? 48 : 56,
                height: isMobile ? 48 : 56,
                decoration: BoxDecoration(
                  color: selected || _isHovering
                      ? Colors.blue.shade100
                      : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  widget.icon,
                  size: isMobile ? 22 : 26,
                  color: selected || _isHovering
                      ? Colors.blue.shade800
                      : Colors.blue.shade700,
                ),
              ),
              SizedBox(height: isMobile ? 10 : 16),
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 16 : (isTablet ? 18 : 20),
                  fontWeight: FontWeight.bold,
                  color: selected || _isHovering
                      ? Colors.blue.shade900
                      : Colors.blue.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 6 : 10),
              // Description (expand when selected)
              Flexible(
                child: Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 12 : (isTablet ? 13 : 15),
                    color: selected || _isHovering
                        ? Colors.blue.shade800
                        : Colors.grey.shade700,
                    height: 1.5,
                  ),
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Flower Industry Design Classes
class LargeFlowerIndustryDesign extends StatelessWidget {
  LargeFlowerIndustryDesign({super.key});

  final List<Map<String, dynamic>> _industries = [
    {
      'title': 'Healthcare',
      'color': Colors.blue.shade800,
      'angle': -90.0,
    },
    {
      'title': 'Education',
      'color': Colors.blue.shade800,
      'angle': -45.0,
    },
    {
      'title': 'Manufacturing',
      'color': Colors.blue.shade800,
      'angle': 0.0,
    },
    {
      'title': 'Logistics',
      'color': Colors.blue.shade800,
      'angle': 45.0,
    },
    {
      'title': 'Wholesale',
      'color': Colors.blue.shade800,
      'angle': 90.0,
    },
    {
      'title': 'Automotive',
      'color': Colors.blue.shade800,
      'angle': 135.0,
    },
    {
      'title': 'Real Estate',
      'color': Colors.blue.shade800,
      'angle': 180.0,
    },
    {
      'title': 'Entertainment',
      'color': Colors.blue.shade800,
      'angle': 225.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;
    final isTablet = screenWidth > 600 && screenWidth <= 1024;

    // Responsive container size with minimum size
    final double containerSize = isMobile
        ? max(screenWidth * 0.85, 280) // Minimum size for very small screens
        : (isTablet ? (screenWidth * 0.7) : (screenWidth * 0.6));

    final double petalWidth =
        isMobile ? (containerSize * 0.32) : (containerSize * 0.30);
    final double petalHeight =
        isMobile ? (containerSize * 0.18) : (containerSize * 0.16);

    final double fontSize = isMobile ? 10 : (isTablet ? 12 : 14);

    return Center(
      child: SizedBox(
        width: containerSize,
        height: containerSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Responsive elongated petals
            ..._industries.map((industry) {
              final angle = industry['angle'] as double;
              final color = industry['color'] as Color;
              final title = industry['title'] as String;

              return _buildLargePetal(
                title: title,
                color: color,
                angle: angle,
                containerSize: containerSize,
                petalWidth: petalWidth,
                petalHeight: petalHeight,
                fontSize: fontSize,
                isMobile: isMobile,
                isTablet: isTablet,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildLargePetal({
    required String title,
    required Color color,
    required double angle,
    required double containerSize,
    required double petalWidth,
    required double petalHeight,
    required double fontSize,
    required bool isMobile,
    bool isTablet = false,
  }) {
    final radian = angle * (pi / 180);

    // Responsive distance from center with minimum spacing
    final distanceFromCenter =
        isMobile ? containerSize * 0.18 : containerSize * 0.22;
    final dx = distanceFromCenter * cos(radian);
    final dy = distanceFromCenter * sin(radian);

    return Positioned(
      left: containerSize / 2 + dx - (petalWidth / 2),
      top: containerSize / 2 + dy - (petalHeight / 2),
      child: Transform.rotate(
        angle: radian,
        child: SizedBox(
          width: petalWidth,
          height: petalHeight,
          child: CustomPaint(
            size: Size(petalWidth, petalHeight),
            painter: LargePetalPainter(color: color),
            child: Transform.rotate(
              angle: -radian,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isMobile ? 6.0 : 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getIndustryIcon(title),
                        color: Colors.white,
                        size: isMobile ? 12 : (isTablet ? 14 : 16),
                      ),
                      SizedBox(height: isMobile ? 2 : 4),
                      Flexible(
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIndustryIcon(String title) {
    switch (title) {
      case 'Healthcare':
        return Icons.medical_services;
      case 'Education':
        return Icons.school;
      case 'Manufacturing':
        return Icons.factory;
      case 'Logistics':
        return Icons.local_shipping;
      case 'Wholesale':
        return Icons.inventory;
      case 'Automotive':
        return Icons.directions_car;
      case 'Real Estate':
        return Icons.home_work;
      case 'Entertainment':
        return Icons.movie;
      default:
        return Icons.business;
    }
  }
}

class LargePetalPainter extends CustomPainter {
  final Color color;

  LargePetalPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Draw large elongated petal shape
    path.moveTo(size.width * 0.5, size.height * 0.95);

    // Extended curves for larger petals
    path.quadraticBezierTo(size.width * 0.05, size.height * 0.7,
        size.width * 0.15, size.height * 0.15);

    path.quadraticBezierTo(size.width * 0.5, size.height * 0.02,
        size.width * 0.85, size.height * 0.15);

    path.quadraticBezierTo(size.width * 0.95, size.height * 0.7,
        size.width * 0.5, size.height * 0.95);

    path.close();

    canvas.drawPath(path, paint);

    // Add border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawPath(path, borderPaint);

    // Add vein details
    final veinPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final veinPath = Path();
    veinPath.moveTo(size.width * 0.5, size.height * 0.95);
    veinPath.quadraticBezierTo(size.width * 0.5, size.height * 0.6,
        size.width * 0.5, size.height * 0.08);
    canvas.drawPath(veinPath, veinPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
