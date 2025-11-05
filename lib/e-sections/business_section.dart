import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessSection extends StatelessWidget {
  const BusinessSection({Key? key}) : super(key: key);

  static const Color primaryColor = Color(0xFF0B0655);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 16 : 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            "Business Solutions",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 26 : 34,
              fontWeight: FontWeight.w700,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "Tailored for every industry – from small shops to large enterprises.",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // Industry Cards
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: const [
              _IndustryCard(
                icon: Icons.shopping_bag_outlined,
                title: "Retail",
                text:
                    "Smart billing and inventory tracking for smooth store management.",
              ),
              _IndustryCard(
                icon: Icons.restaurant_menu,
                title: "Restaurants",
                text:
                    "Menu, table, and order handling made simple and efficient.",
              ),
              _IndustryCard(
                icon: Icons.hotel,
                title: "Hotels",
                text: "Manage room billing and guest services in one system.",
              ),
              _IndustryCard(
                icon: Icons.build_circle_outlined,
                title: "Service Centers",
                text:
                    "Easily track jobs, invoices, and appointments in one place.",
              ),
            ],
          ),

          const SizedBox(height: 60),

          // Case Studies
          Text(
            "Case Studies",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "See how different industries improved their billing with BillTill.",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 15,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: const [
              _CaseStudyCard(
                icon: Icons.store_mall_directory,
                title: "Retail Chain",
                subtitle: "Increased efficiency by 30%",
              ),
              _CaseStudyCard(
                icon: Icons.local_dining,
                title: "Fine Dining",
                subtitle: "Reduced wait times by 40%",
              ),
              _CaseStudyCard(
                icon: Icons.king_bed_outlined,
                title: "Hotel Group",
                subtitle: "Automated billing across branches",
              ),
            ],
          ),

          const SizedBox(height: 60),

          // CTA
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 40 : 60,
              horizontal: 20,
            ),
            child: Column(
              children: [
                Text(
                  "Talk to Our Enterprise Team",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: isMobile ? 20 : 26,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "Get personalized solutions for your business.",
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: isMobile ? 13 : 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Contact Us",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---- Components ----

class _IndustryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  static const Color primaryColor = Color(0xFF0B0655);

  const _IndustryCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE3E8F0)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 36, color: primaryColor),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey[700],
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CaseStudyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  static const Color primaryColor = Color(0xFF0B0655);

  const _CaseStudyCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFE3E8F0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 34, color: primaryColor),
          const SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey[700],
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
