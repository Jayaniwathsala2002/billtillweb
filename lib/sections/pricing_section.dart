// lib/sections/pricing_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PricingSection extends StatefulWidget {
  const PricingSection({Key? key}) : super(key: key);

  @override
  State<PricingSection> createState() => _PricingSectionState();
}

class _PricingSectionState extends State<PricingSection> {
  Future<void> _launchURL(String urlString) async {
    // Remove extra spaces
    final cleanUrl = urlString.trim();
    final uri = Uri.tryParse(cleanUrl);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open $cleanUrl')),
      );
    }
  }

  void _showBillingHelp() {
    _launchURL('https://support.yourapp.com/billing');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;
    final bool isTablet = size.width < 1200 && !isMobile;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // === PRICING PLANS SECTION ===
          Container(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 40 : 80,
              horizontal: isMobile ? 16 : 20,
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                Text(
                  'Choose the plan that’s right for you',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0B0655),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'All plans include access to our core features. Upgrade for advanced tools.',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 16 : 18,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Plans
                isMobile
                    ? Column(
                        children: [
                          _PlanCard(
                            title: 'Plus',
                            price: '\$20',
                            period: 'USD / month',
                            description:
                                'Level up productivity and creativity with expanded access',
                            features: [
                              'Everything in Free',
                              'Extended limits on messaging, file uploads, advanced data analysis, and image generation',
                              'Access to advanced voice and video inputs',
                              'Limited access to o1 and o1-mini',
                              'Opportunities to test new features',
                              'Create and use projects and custom GPTs',
                              'Limited access to Sora video generation',
                            ],
                            isCurrent: true,
                            buttonText: 'Your current plan',
                            buttonColor: Colors.grey.shade200,
                            textColor: Colors.black,
                            onButtonPressed: () {},
                            isMobile: isMobile,
                          ),
                          const SizedBox(height: 30),
                          _PlanCard(
                            title: 'Pro',
                            price: '\$200',
                            period: 'USD / month',
                            description:
                                'Get the best of OpenAI with the highest level of access',
                            features: [
                              'Everything in Plus',
                              'Unlimited access to o1, o1-mini, GPT-4o, and advanced voice (audio only)',
                              'Higher limits for video and screensharing in advanced voice',
                              'Access to o1 pro mode, which uses more compute for the best answers to the hardest questions',
                              'Extended access to Sora video generation',
                            ],
                            isCurrent: false,
                            buttonText: 'Get Pro',
                            buttonColor: const Color(0xFF0B0655),
                            textColor: Colors.white,
                            onButtonPressed: () {
                              _launchURL(
                                  'https://payhere.lk/billtill/pro_monthly');
                            },
                            isMobile: isMobile,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _PlanCard(
                              title: 'Plus',
                              price: '\$20',
                              period: 'USD / month',
                              description:
                                  'Level up productivity and creativity with expanded access',
                              features: [
                                'Everything in Free',
                                'Extended limits on messaging, file uploads, advanced data analysis, and image generation',
                                'Access to advanced voice and video inputs',
                                'Limited access to o1 and o1-mini',
                                'Opportunities to test new features',
                                'Create and use projects and custom GPTs',
                                'Limited access to Sora video generation',
                              ],
                              isCurrent: true,
                              buttonText: 'Your current plan',
                              buttonColor: Colors.grey.shade200,
                              textColor: Colors.black,
                              onButtonPressed: () {},
                              isMobile: isMobile,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: _PlanCard(
                              title: 'Pro',
                              price: '\$200',
                              period: 'USD / month',
                              description:
                                  'Get the best of OpenAI with the highest level of access',
                              features: [
                                'Everything in Plus',
                                'Unlimited access to o1, o1-mini, GPT-4o, and advanced voice (audio only)',
                                'Higher limits for video and screensharing in advanced voice',
                                'Access to o1 pro mode, which uses more compute for the best answers to the hardest questions',
                                'Extended access to Sora video generation',
                              ],
                              isCurrent: false,
                              buttonText: 'Get Pro',
                              buttonColor: const Color(0xFF0B0655),
                              textColor: Colors.white,
                              onButtonPressed: () {
                                _launchURL(
                                    'https://payhere.lk/billtill/pro_monthly');
                              },
                              isMobile: isMobile,
                            ),
                          ),
                        ],
                      ),

                // Footer Links
                const SizedBox(height: 60),
              ],
            ),
          ),

          // === HARDWARE & ADD-ONS SECTION ===
          Container(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 60 : 80,
              horizontal: isMobile ? 16 : 20,
            ),
            color: Colors.grey.shade50,
            child: Column(
              children: [
                Text(
                  'Hardware & Add-ons',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 24 : (isTablet ? 28 : 32),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0B0655),
                  ),
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: isMobile ? 16 : 30,
                  runSpacing: isMobile ? 16 : 30,
                  alignment: WrapAlignment.center,
                  children: [
                    _AddonCard(
                      title: 'Thermal Printer',
                      description:
                          '58mm thermal receipt printer with USB connectivity',
                      icon: Icons.print,
                      isMobile: isMobile,
                    ),
                    _AddonCard(
                      title: 'Barcode Scanner',
                      description:
                          'USB barcode scanner for quick product lookup',
                      icon: Icons.qr_code_scanner,
                      isMobile: isMobile,
                    ),
                    _AddonCard(
                      title: 'Cash Drawer',
                      description: 'Secure cash drawer with printer trigger',
                      icon: Icons.account_balance_wallet,
                      isMobile: isMobile,
                    ),
                    _AddonCard(
                      title: 'Training Session',
                      description: '2-hour personalized training for your team',
                      icon: Icons.school,
                      isMobile: isMobile,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // === SECURE PAYMENT GATEWAY SECTION ===
          Container(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 60 : 80,
              horizontal: isMobile ? 16 : 20,
            ),
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  'Secure Payment Gateway',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 22 : (isTablet ? 24 : 28),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0B0655).withOpacity(0.827),
                  ),
                ),
                const SizedBox(height: 30),
                isMobile
                    ? Column(
                        children: [
                          _PaymentPartner(
                            name: 'Seylan Bank',
                            description: 'Card payments & installments',
                            icon: Icons.credit_card,
                            isMobile: isMobile,
                          ),
                          const SizedBox(height: 30),
                          _PaymentPartner(
                            name: 'PayHere',
                            description: 'Online payments & subscriptions',
                            icon: Icons.payment,
                            isMobile: isMobile,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _PaymentPartner(
                            name: 'Seylan Bank',
                            description: 'Card payments & installments',
                            icon: Icons.credit_card,
                            isMobile: isMobile,
                          ),
                          SizedBox(width: isTablet ? 30 : 60),
                          _PaymentPartner(
                            name: 'PayHere',
                            description: 'Online payments & subscriptions',
                            icon: Icons.payment,
                            isMobile: isMobile,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ====== PLAN CARD (NEW STYLE) ======
class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final String description;
  final List<String> features;
  final bool isCurrent;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onButtonPressed;
  final bool isMobile;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    required this.isCurrent,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
    required this.onButtonPressed,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isMobile
          ? const EdgeInsets.all(20)
          : const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 24 : 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0B0655),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                price,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 32 : 40,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0B0655),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                period,
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features.map((feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green.shade600,
                      size: isMobile ? 16 : 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: isMobile ? 13 : 15,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: textColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          if (isCurrent)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Your current plan',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ====== ADDON CARD (FROM ORIGINAL) ======
class _AddonCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isMobile;

  const _AddonCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isMobile,
  });

  @override
  State<_AddonCard> createState() => _AddonCardState();
}

class _AddonCardState extends State<_AddonCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: widget.isMobile ? double.infinity : 250,
        padding: widget.isMobile
            ? const EdgeInsets.all(16)
            : const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 253, 242, 255),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Colors.black.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.1),
              blurRadius: _isHovered ? 15 : 10,
              offset: _isHovered ? const Offset(0, 8) : const Offset(0, 5),
              spreadRadius: _isHovered ? 1 : 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: widget.isMobile ? 40 : 48,
              color: Colors.blue.shade600,
            ),
            SizedBox(height: widget.isMobile ? 12 : 16),
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                fontSize: widget.isMobile ? 18 : 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0B0655).withOpacity(0.827),
              ),
            ),
            SizedBox(height: widget.isMobile ? 8 : 12),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: widget.isMobile ? 14 : 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ====== PAYMENT PARTNER (FROM ORIGINAL) ======
class _PaymentPartner extends StatefulWidget {
  final String name;
  final String description;
  final IconData icon;
  final bool isMobile;

  const _PaymentPartner({
    required this.name,
    required this.description,
    required this.icon,
    required this.isMobile,
  });

  @override
  _PaymentPartnerState createState() => _PaymentPartnerState();
}

class _PaymentPartnerState extends State<_PaymentPartner> {
  bool _isHovered = false;
  final Duration _animationDuration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: _animationDuration,
        curve: Curves.easeInOut,
        padding: widget.isMobile
            ? const EdgeInsets.all(16)
            : const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isHovered
              ? const Color(0xFF0B0655).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF0B0655).withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: _animationDuration,
              curve: Curves.easeInOut,
              width: _isHovered
                  ? (widget.isMobile ? 70 : 90)
                  : (widget.isMobile ? 60 : 80),
              height: _isHovered
                  ? (widget.isMobile ? 70 : 90)
                  : (widget.isMobile ? 60 : 80),
              decoration: BoxDecoration(
                color: _isHovered
                    ? const Color(0xFF0B0655).withOpacity(0.1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(45),
                border: Border.all(
                  color: _isHovered
                      ? const Color(0xFF0B0655).withOpacity(0.827)
                      : const Color(0xFF0B0655).withOpacity(0.3),
                  width: _isHovered ? 2 : 1,
                ),
              ),
              child: AnimatedScale(
                duration: _animationDuration,
                scale: _isHovered ? 1.1 : 1.0,
                child: Icon(
                  widget.icon,
                  size: widget.isMobile ? 30 : 40,
                  color: _isHovered
                      ? const Color(0xFF0B0655).withOpacity(0.827)
                      : const Color(0xFF0B0655).withOpacity(0.7),
                ),
              ),
            ),
            SizedBox(height: widget.isMobile ? 12 : 16),
            AnimatedDefaultTextStyle(
              duration: _animationDuration,
              style: GoogleFonts.poppins(
                fontSize: _isHovered
                    ? (widget.isMobile ? 18 : 22)
                    : (widget.isMobile ? 16 : 20),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0B0655).withOpacity(0.827),
              ),
              child: Text(widget.name),
            ),
            SizedBox(height: widget.isMobile ? 6 : 8),
            AnimatedDefaultTextStyle(
              duration: _animationDuration,
              style: TextStyle(
                fontSize: _isHovered
                    ? (widget.isMobile ? 13 : 15)
                    : (widget.isMobile ? 12 : 14),
                color: _isHovered
                    ? const Color(0xFF0B0655).withOpacity(0.8)
                    : const Color(0xFF0B0655).withOpacity(0.6),
                fontWeight: _isHovered ? FontWeight.w500 : FontWeight.normal,
              ),
              child: Text(widget.description),
            ),
            SizedBox(height: widget.isMobile ? 8 : 10),
            AnimatedOpacity(
              duration: _animationDuration,
              opacity: _isHovered ? 1.0 : 0.0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B0655).withOpacity(0.827),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Click to pay',
                  style: GoogleFonts.poppins(
                    fontSize: widget.isMobile ? 10 : 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
