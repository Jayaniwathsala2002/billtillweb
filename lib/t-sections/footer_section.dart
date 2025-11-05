// lib/e-sections/footer_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  final void Function(String sectionId)? onQuickLinkTap;

  const FooterSection({Key? key, this.onQuickLinkTap}) : super(key: key);

  Future<void> _launchURL(String url) async {
    if (url.startsWith('#')) {
      onQuickLinkTap?.call(url.substring(1));
    } else {
      final uri = Uri.parse(url.trim());
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      color: const Color(0xFF0B0655),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 30 : 50,
      ),
      child: Column(
        children: [
          isMobile
              ? _buildMobileContent(context, isMobile)
              : _buildDesktopContent(context, isMobile),
          const SizedBox(height: 40),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.2),
            width: double.infinity,
          ),
          const SizedBox(height: 20),
          Text(
            '© 2025 Bill Till – Smart Billing for a Connected Nation.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopContent(BuildContext context, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogoSection(isMobile),
        _buildAboutUsSection(),
        const SizedBox(width: 50),
        _buildContactUsSection(),
        _buildQuickLinksSection(),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLogoSection(isMobile),
        const SizedBox(height: 24),
        _buildAboutUsSection(),
        const SizedBox(height: 24),
        _buildContactUsSection(),
        const SizedBox(height: 24),
        _buildQuickLinksSection(),
      ],
    );
  }

  Widget _buildLogoSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/hero/logo.png',
          width: isMobile ? 120 : 200,
          height: isMobile ? 120 : 200,
          fit: BoxFit.contain,
        ),
      ],
    );
  }

  Widget _buildAboutUsSection() {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'About Us',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'For over a decade, our team has been dedicated to providing industry-leading POS and retail management solutions, now deployed in numerous F&B and retail outlets across Sri Lanka and the region.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildContactUsSection() {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.white70, size: 16),
              SizedBox(width: 8),
              Text(
                '+94 31 2285 003',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.email, color: Colors.white70, size: 16),
              SizedBox(width: 8),
              Text(
                'info@billtill.co',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.language, color: Colors.white70, size: 16),
              SizedBox(width: 8),
              Text(
                'www.billtill.co',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on, color: Colors.white70, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '680A, Colombo Road, Kattuwa, Negombo, Sri Lanka',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLinksSection() {
    final links = [
      {'Home': '#home'},
      {'Features': '#features'},
      {'Pricing': '#pricing'},
      {'Partners': '#partners'},
      {'Business': '#business'},
      {'About': '#about'},
      {'Contact': '#contact'},
    ];

    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Quick Links',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 8,
            children: links.map((entry) {
              final text = entry.keys.first;
              final url = entry.values.first;
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _launchURL(url),
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.facebook, color: Colors.white70),
                onPressed: () =>
                    _launchURL('https://www.facebook.com/ceyloninnovation'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
