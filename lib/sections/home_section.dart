// lib/sections/home_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class HomeSection extends StatefulWidget {
  final bool isMobile;
  final VoidCallback onInvoiceTap;
  final VoidCallback onViewPricingTap; // ✅ This will scroll to Pricing

  const HomeSection({
    Key? key,
    required this.isMobile,
    required this.onInvoiceTap,
    required this.onViewPricingTap,
  }) : super(key: key);

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  final List<String> _images = [
    'assets/images/hero/hero1.jpeg',
    'assets/images/hero/hero2.jpeg',
    'assets/images/hero/hero3.jpeg',
  ];

  final List<String> _words = ['RETAIL', 'RESTAURANT', 'RENT-A-CAR'];
  int _currentSlide = 0;
  int _currentWord = 0;

  late Timer _slideTimer;
  late Timer _wordTimer;

  @override
  void initState() {
    super.initState();
    _slideTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (mounted) {
        setState(() {
          _currentSlide = (_currentSlide + 1) % _images.length;
        });
      }
    });

    _wordTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (mounted) {
        setState(() {
          _currentWord = (_currentWord + 1) % _words.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _slideTimer.cancel();
    _wordTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final bool isMobile = widget.isMobile;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          // Background Carousel
          ...List.generate(_images.length, (index) {
            return AnimatedOpacity(
              opacity: index == _currentSlide ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 600),
              child: Image.asset(
                _images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            );
          }),

          // Dark overlay
          Container(
            color: const Color(0xFF0B0655).withAlpha((0.827 * 255).round()),
          ),

          // Content
          Padding(
            padding: EdgeInsets.fromLTRB(
              isMobile ? 20 : 50,
              isMobile ? 100 : 250,
              isMobile ? 20 : 50,
              40,
            ),
            child: Column(
              mainAxisAlignment:
                  isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 28 : 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: [
                      const TextSpan(text: 'BILL TILL – POS FOR\n'),
                      const TextSpan(
                        text: 'REIMAGINED\n',
                        style: TextStyle(color: Color(0xFF43B9FE)),
                      ),
                      TextSpan(text: _words[_currentWord]),
                    ],
                  ),
                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: widget.onViewPricingTap, // ✅ Scrolls to Pricing
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'View Pricing',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isMobile) ...[
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 280,
                    child: ElevatedButton(
                      onPressed: widget.onInvoiceTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF43B9FE),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        'FREE INVOICE GENERATOR',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 100),
                // Carousel Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_images.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: 25,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        color: index == _currentSlide
                            ? const Color(0xFF43B9FE)
                            : null,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
