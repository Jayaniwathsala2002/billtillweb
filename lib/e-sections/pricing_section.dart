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
              vertical: isMobile ? 32 : 60,
              horizontal: isMobile ? 16 : 20,
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Choose the plan that’s right for you',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 26 : 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0B0655),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'All plans include access to our core features. Upgrade for advanced tools.',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Plans
                if (isMobile)
                  Column(
                    children: [
                      _PlanCard(
                        title: 'Plus',
                        price: '\$20',
                        period: 'USD / month',
                        description: 'Expanded access for growing businesses',
                        features: [
                          'Everything in Free',
                          'Extended messaging & file uploads',
                          'Advanced data analysis',
                          'Limited o1 & o1-mini access',
                          'Create custom GPTs',
                        ],
                        isCurrent: true,
                        buttonText: 'Your current plan',
                        buttonColor: Colors.grey.shade200,
                        textColor: Colors.black,
                        onButtonPressed: () {},
                        isMobile: isMobile,
                      ),
                      const SizedBox(height: 20),
                      _PlanCard(
                        title: 'Pro',
                        price: '\$200',
                        period: 'USD / month',
                        description: 'Full access for power users',
                        features: [
                          'Everything in Plus',
                          'Unlimited o1, GPT-4o, advanced voice',
                          'Higher video/screenshare limits',
                          'o1 pro mode',
                          'Extended Sora access',
                        ],
                        isCurrent: false,
                        buttonText: 'Get Pro',
                        buttonColor: const Color(0xFF0B0655),
                        textColor: Colors.white,
                        onButtonPressed: () {
                          _launchURL('https://payhere.lk/billtill/pro_monthly');
                        },
                        isMobile: isMobile,
                      ),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _PlanCard(
                        title: 'Plus',
                        price: '\$20',
                        period: 'USD / month',
                        description: 'Expanded access for growing businesses',
                        features: [
                          'Everything in Free',
                          'Extended messaging & file uploads',
                          'Advanced data analysis',
                          'Limited o1 & o1-mini access',
                          'Create custom GPTs',
                        ],
                        isCurrent: true,
                        buttonText: 'Your current plan',
                        buttonColor: Colors.grey.shade200,
                        textColor: Colors.black,
                        onButtonPressed: () {},
                        isMobile: isMobile,
                      ),
                      const SizedBox(width: 24),
                      _PlanCard(
                        title: 'Pro',
                        price: '\$200',
                        period: 'USD / month',
                        description: 'Full access for power users',
                        features: [
                          'Everything in Plus',
                          'Unlimited o1, GPT-4o, advanced voice',
                          'Higher video/screenshare limits',
                          'o1 pro mode',
                          'Extended Sora access',
                        ],
                        isCurrent: false,
                        buttonText: 'Get Pro',
                        buttonColor: const Color(0xFF0B0655),
                        textColor: Colors.white,
                        onButtonPressed: () {
                          _launchURL('https://payhere.lk/billtill/pro_monthly');
                        },
                        isMobile: isMobile,
                      ),
                    ],
                  ),
              ],
            ),
          ),

          // === HARDWARE & ADD-ONS SECTION ===
          Container(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 40 : 50,
              horizontal: isMobile ? 16 : 20,
            ),
            color: Colors.grey.shade50,
            child: Column(
              children: [
                Text(
                  'Hardware & Add-ons',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 22 : 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0B0655),
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: isMobile ? 12 : 20,
                  runSpacing: isMobile ? 12 : 20,
                  alignment: WrapAlignment.center,
                  children: [
                    _AddonCard(
                      title: 'Thermal Printer',
                      description: '58mm USB receipt printer',
                      icon: Icons.print,
                      isMobile: isMobile,
                    ),
                    _AddonCard(
                      title: 'Barcode Scanner',
                      description: 'USB scanner for quick lookup',
                      icon: Icons.qr_code_scanner,
                      isMobile: isMobile,
                    ),
                    _AddonCard(
                      title: 'Cash Drawer',
                      description: 'Printer-triggered secure drawer',
                      icon: Icons.account_balance_wallet,
                      isMobile: isMobile,
                    ),
                    _AddonCard(
                      title: 'Training Session',
                      description: '2-hour team training',
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
              vertical: isMobile ? 40 : 50,
              horizontal: isMobile ? 16 : 20,
            ),
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  'Secure Payment Gateway',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0B0655).withOpacity(0.827),
                  ),
                ),
                const SizedBox(height: 24),
                if (isMobile)
                  Column(
                    children: [
                      _PaymentPartner(
                        name: 'Seylan Bank',
                        description: 'Cards & installments',
                        icon: Icons.credit_card,
                        isMobile: isMobile,
                      ),
                      const SizedBox(height: 20),
                      _PaymentPartner(
                        name: 'PayHere',
                        description: 'Online payments',
                        icon: Icons.payment,
                        isMobile: isMobile,
                      ),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _PaymentPartner(
                        name: 'Seylan Bank',
                        description: 'Cards & installments',
                        icon: Icons.credit_card,
                        isMobile: isMobile,
                      ),
                      const SizedBox(width: 30),
                      _PaymentPartner(
                        name: 'PayHere',
                        description: 'Online payments',
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

// ====== COMPACT PLAN CARD ======
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
      width: isMobile ? double.infinity : 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 20 : 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0B0655),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                price,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 28 : 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0B0655),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                period,
                style: TextStyle(
                  fontSize: isMobile ? 11 : 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: isMobile ? 13 : 14,
              color: Colors.grey.shade700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features.map((feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green.shade600,
                      size: isMobile ? 14 : 16,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 13,
                          color: Colors.grey.shade700,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: textColor,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: isMobile ? 13 : 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          if (isCurrent)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Your current plan',
                style: TextStyle(
                  fontSize: 11,
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

// ====== COMPACT ADDON CARD ======
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
        duration: const Duration(milliseconds: 200),
        width: widget.isMobile ? double.infinity : 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Colors.black.withOpacity(0.1)
                  : Colors.transparent,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: widget.isMobile ? 32 : 36,
              color: const Color(0xFF0B0655),
            ),
            const SizedBox(height: 8),
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                fontSize: widget.isMobile ? 16 : 17,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0B0655),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: widget.isMobile ? 12 : 13,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ====== COMPACT PAYMENT PARTNER ======
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
  final Duration _animationDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: _animationDuration,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Colors.black.withOpacity(0.08)
                  : Colors.transparent,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: widget.isMobile ? 28 : 32,
              color: const Color(0xFF0B0655),
            ),
            const SizedBox(height: 10),
            Text(
              widget.name,
              style: GoogleFonts.poppins(
                fontSize: widget.isMobile ? 16 : 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0B0655),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.description,
              style: TextStyle(
                fontSize: widget.isMobile ? 12 : 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
