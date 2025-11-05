import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PartnersSection extends StatefulWidget {
  const PartnersSection({Key? key}) : super(key: key);

  @override
  State<PartnersSection> createState() => _PartnersSectionState();
}

class _PartnersSectionState extends State<PartnersSection> {
  int? _hoveredIndex;

  void _handleHover(int? index) {
    setState(() => _hoveredIndex = index);
  }

  void _showPartnerForm() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Partner Signup"),
        content: const Text(
            "Our partner form will be available soon.\nThank you for your interest!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header
            Text(
              "Grow Together with Bill Till",
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 30 : 44,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B0655),
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Become our City Franchise or Independent Broker and earn lifetime rewards.",
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 16 : 18,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: _showPartnerForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B0655),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "Become a Partner",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 60),

            // Model Section
            Text(
              "Choose Your Model",
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 26 : 34,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B0655),
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: [
                _PartnerCard(
                  title: "City Franchise",
                  description:
                      "Own exclusive rights to operate Bill Till services in your city or region.",
                  highlights: [
                    "Exclusive Territory",
                    "High Commissions",
                    "Marketing Support",
                  ],
                  hovered: _hoveredIndex == 0,
                  onHover: (hover) => _handleHover(hover ? 0 : null),
                ),
                _PartnerCard(
                  title: "Independent Broker",
                  description:
                      "Work flexibly as a broker and earn commissions for every client you bring.",
                  highlights: [
                    "Lifetime Commission",
                    "No Investment",
                    "Flexible Hours",
                  ],
                  hovered: _hoveredIndex == 1,
                  onHover: (hover) => _handleHover(hover ? 1 : null),
                ),
              ],
            ),
            const SizedBox(height: 60),

            // Benefits Section
            Text(
              "Partner Benefits",
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 26 : 34,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B0655),
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: const [
                _BenefitTile(
                    icon: Icons.attach_money,
                    title: "Lifetime Commission",
                    desc: "Earn continuous income from your referred clients."),
                _BenefitTile(
                    icon: Icons.school,
                    title: "Comprehensive Training",
                    desc:
                        "Access to product, sales, and customer handling training."),
                _BenefitTile(
                    icon: Icons.support_agent,
                    title: "Dedicated Support",
                    desc:
                        "Our partner team is here to assist you 24/7 with any need."),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Partner Card Widget
class _PartnerCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> highlights;
  final bool hovered;
  final Function(bool) onHover;

  const _PartnerCard({
    required this.title,
    required this.description,
    required this.highlights,
    required this.hovered,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: isMobile ? double.infinity : 350,
        height: 380,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: hovered ? const Color(0xFF0B0655) : Colors.grey.shade300,
            width: hovered ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: hovered
                  ? const Color(0x220B0655)
                  : Colors.grey.shade200.withOpacity(0.5),
              blurRadius: hovered ? 16 : 6,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(Icons.store_mall_directory,
                color: const Color(0xFF0B0655), size: 46),
            const SizedBox(height: 14),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 20 : 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0B0655),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.grey.shade700,
                fontSize: isMobile ? 14 : 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: highlights
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle,
                              color: Colors.green, size: 18),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              item,
                              style: GoogleFonts.poppins(
                                color: Colors.grey.shade800,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Apply for $title"),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B0655),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "Apply Now",
                style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Benefit Tile Widget
class _BenefitTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _BenefitTile({
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: isMobile ? double.infinity : 260,
      height: 250,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF0B0655), size: 44),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0B0655),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.grey.shade700,
              fontSize: isMobile ? 14 : 15,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
