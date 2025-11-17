import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class HomeSection extends StatefulWidget {
  final bool isMobile;
  final VoidCallback onInvoiceTap;
  final VoidCallback onViewPricingTap;

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

  final List<String> _words = [
    'விற்பனைக் கடைகளுக்கு',
    'உணவகங்களுக்கு',
    'வாகன வாடகைக்கு'
  ];
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

  Future<void> _openInvoiceGenerator() async {
    final Uri url = Uri.parse('https://billtillweb.vercel.app/web/index.html');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to open invoice generator.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final bool isMobile = widget.isMobile;

    double textContainerHeight = isMobile ? 180.0 : 120.0;

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

          // Dark overlay with gradient as shadow
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xCC170069), // 0.85 opacity for #170069
                  Color(0xCC0053C0), // 0.85 opacity for #0053C0
                ],
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.fromLTRB(
              isMobile ? 20 : 50,
              isMobile ? 150 : 300,
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
                SizedBox(
                  height: textContainerHeight,
                  child: Container(
                    alignment:
                        isMobile ? Alignment.center : Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 28 : 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: const [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        children: [
                          const TextSpan(
                            text: 'மறுவடிவமைப்பு செய்யப்பட்ட POS\n',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: _words[_currentWord],
                            style: const TextStyle(color: Color(0xFF0053C0)),
                          ),
                        ],
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: widget.onViewPricingTap,
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
                      onPressed: _openInvoiceGenerator,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0053C0),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        'விலைப்பட்டியல் பெறுதல்',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 70),
                // Carousel Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_images.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
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
                            ? Colors.white
                            : const Color(0xFF170069),
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
