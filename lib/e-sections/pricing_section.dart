// lib/e-sections/pricing_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PricingSection extends StatefulWidget {
  const PricingSection({Key? key}) : super(key: key);

  @override
  State<PricingSection> createState() => _PricingSectionState();
}

class _PricingSectionState extends State<PricingSection> {
  int _selectedPlanIndex = 0; // Auto-select first plan

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

    const hardwareItems = [
      HardwareItem('Thermal Printer', '58mm USB receipt printer', Icons.print),
      HardwareItem('Barcode Scanner', 'USB scanner for quick lookup',
          Icons.qr_code_scanner),
      HardwareItem('Cash Drawer', 'Printer-triggered secure drawer',
          Icons.account_balance_wallet),
      HardwareItem('Training Session', '2-hour team training', Icons.school),
    ];

    const plans = [
      PlanData(
        title: 'Dynamics',
        price: 'Rs. 5,999',
        description: 'For small businesses',
        features: [
          'Create & manage invoices',
          'Customer database',
          'Basic reporting',
          'Receipt printing',
          'Email support',
        ],
        isPopular: false,
        url: 'https://payhere.lk/billtill/dynamics',
      ),
      PlanData(
        title: 'Pro',
        price: 'Rs. 9,999',
        description: 'For larger operations',
        features: [
          'Everything in Dynamics',
          'Advanced inventory tracking',
          'Multi-user access (up to 5)',
          'Financial dashboards',
          'Priority support',
        ],
        isPopular: true,
        url: 'https://payhere.lk/billtill/pro',
      ),
    ];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: isMobile ? 40 : 60),
      child: Column(
        children: [
          // ---- HEADER ----
          Container(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Choose the plan that’s right for you',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 30 : 42,
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
                const SizedBox(height: 40),

                // ---- PRICING CARDS ----
                if (isMobile)
                  Column(
                    children: _buildPricingCards(plans, isMobile),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPricingCards(plans, isMobile),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // ---- HARDWARE SECTION ----
          _buildHardwareSection(isMobile, hardwareItems),

          const SizedBox(height: 60),

          // ---- SECURE PAYMENT SECTION ----
          _buildSecurePaymentSection(isMobile),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  // ===================== SECTIONS =====================

  List<Widget> _buildPricingCards(List<PlanData> plans, bool isMobile) {
    return List.generate(plans.length, (i) {
      final plan = plans[i];
      return GestureDetector(
        onTap: () => setState(() => _selectedPlanIndex = i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(
            bottom: isMobile ? 24 : 0,
            right: !isMobile && i == 0 ? 32 : 0,
          ),
          child: Transform.scale(
            scale: _selectedPlanIndex == i ? 1.03 : 1.0,
            child: SizedBox(
              width: isMobile ? double.infinity : 420,
              height: 420,
              child: _PlanCard(
                title: plan.title,
                price: plan.price,
                description: plan.description,
                features: plan.features,
                isPopular: plan.isPopular,
                isCurrent: _selectedPlanIndex == i,
                buttonText: 'Get Started',
                buttonColor: const Color(0xFF0B0655),
                textColor: Colors.white,
                onButtonPressed: () => _launchURL(plan.url),
                isMobile: isMobile,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHardwareSection(bool isMobile, List<HardwareItem> items) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
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
          const SizedBox(height: 20),
          Wrap(
            spacing: isMobile ? 12 : 24,
            runSpacing: isMobile ? 12 : 24,
            alignment: WrapAlignment.center,
            children: items
                .map((item) => _CompactRectangleCard(
                      title: item.title,
                      description: item.description,
                      icon: item.icon,
                      isMobile: isMobile,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurePaymentSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Secure Payment Gateway',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0B0655),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'We’ve partnered with trusted payment providers to ensure safe and smooth transactions.',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 13 : 15,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          if (isMobile)
            Column(
              children: [
                _ModernPaymentCard(
                  name: 'Seylan Bank',
                  description: 'Credit & Debit Cards, Installments',
                  icon: Icons.credit_card,
                  onTap: () {},
                  isMobile: isMobile,
                ),
                const SizedBox(height: 16),
                _ModernPaymentCard(
                  name: 'PayHere',
                  description: 'Online Payments & Recurring Billing',
                  icon: Icons.payment,
                  onTap: () {},
                  isMobile: isMobile,
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _ModernPaymentCard(
                    name: 'Seylan Bank',
                    description: 'Credit & Debit Cards, Installments',
                    icon: Icons.credit_card,
                    onTap: () {},
                    isMobile: isMobile,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _ModernPaymentCard(
                    name: 'PayHere',
                    description: 'Online Payments & Recurring Billing',
                    icon: Icons.payment,
                    onTap: () {},
                    isMobile: isMobile,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// ===================== DATA CLASSES =====================

class PlanData {
  final String title;
  final String price;
  final String description;
  final List<String> features;
  final bool isPopular;
  final String url;
  const PlanData({
    required this.title,
    required this.price,
    required this.description,
    required this.features,
    required this.isPopular,
    required this.url,
  });
}

class HardwareItem {
  final String title;
  final String description;
  final IconData icon;
  const HardwareItem(this.title, this.description, this.icon);
}

// ===================== UI COMPONENTS =====================

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final List<String> features;
  final bool isPopular;
  final bool isCurrent;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onButtonPressed;
  final bool isMobile;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.description,
    required this.features,
    required this.isPopular,
    required this.isCurrent,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
    required this.onButtonPressed,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: isPopular ? 20 : 0),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isCurrent ? const Color(0xFF0B0655) : Colors.grey.shade200,
              width: isCurrent ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 12,
                offset: const Offset(0, 4),
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
              Text(
                price,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 28 : 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0B0655),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: isMobile ? 13 : 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: features.map((feature) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle,
                              color: Colors.green.shade600,
                              size: isMobile ? 14 : 16),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyle(
                                fontSize: isMobile ? 12 : 13,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
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
            ],
          ),
        ),

        // ---- Popular Badge ----
        if (isPopular)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0B0655), Color(0xFF1E1072)],
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              alignment: Alignment.center,
              child: Text(
                'Most Popular',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ===================== HARDWARE CARD =====================

class _CompactRectangleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isMobile;

  const _CompactRectangleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? double.infinity : 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 26, color: const Color(0xFF0B0655)),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0B0655),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
                color: Colors.grey.shade600, fontSize: isMobile ? 11 : 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ===================== MODERN PAYMENT CARD =====================

class _ModernPaymentCard extends StatefulWidget {
  final String name;
  final String description;
  final IconData icon;
  final VoidCallback onTap;
  final bool isMobile;

  const _ModernPaymentCard({
    required this.name,
    required this.description,
    required this.icon,
    required this.onTap,
    required this.isMobile,
  });

  @override
  State<_ModernPaymentCard> createState() => _ModernPaymentCardState();
}

class _ModernPaymentCardState extends State<_ModernPaymentCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0B0655), Color(0xFF1E1072)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovered ? 0.25 : 0.1),
              blurRadius: _hovered ? 14 : 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 34, color: Colors.white),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: GoogleFonts.poppins(
                        fontSize: widget.isMobile ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.description,
                      style: GoogleFonts.poppins(
                        fontSize: widget.isMobile ? 12 : 13,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
