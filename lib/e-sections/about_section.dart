import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Bill Till Brand Color: #0B0655 → R:11, G:6, B:85
const Color billTillSolid = Color.fromRGBO(11, 6, 85, 1.0);
const Color billTill827 = Color.fromRGBO(11, 6, 85, 0.827);
const Color billTill70 = Color.fromRGBO(11, 6, 85, 0.7);
const Color billTill50 = Color.fromRGBO(11, 6, 85, 0.5);
const Color billTill20 = Color.fromRGBO(11, 6, 85, 0.2);
const Color billTill15 = Color.fromRGBO(11, 6, 85, 0.15);

// Helper to safely create color with opacity (non-const)
Color _withOpacity(Color base, double opacity) {
  return Color.fromRGBO(11, 6, 85, opacity);
}

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // ===== About Us — No Background =====
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 30 : 50,
              horizontal: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'About Us',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 28 : 32,
                    fontWeight: FontWeight.bold,
                    color: billTill827,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Bill Till is a product of Ceylon Innovation Services (PVT) LTD',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 16 : 18,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: isMobile ? 16 : 28,
                  runSpacing: isMobile ? 16 : 28,
                  alignment: WrapAlignment.center,
                  children: [
                    SizedBox(
                      width: isMobile ? 280 : 300,
                      height: isMobile ? 220 : 240,
                      child: _StyledHoverCompanyInfoCard(
                        icon: Icons.history,
                        title: 'Our Story',
                        description:
                            'Founded to solve billing challenges faced by Sri Lankan businesses with innovative technology solutions.',
                      ),
                    ),
                    SizedBox(
                      width: isMobile ? 280 : 300,
                      height: isMobile ? 220 : 240,
                      child: _StyledHoverCompanyInfoCard(
                        icon: Icons.flag,
                        title: 'Our Mission',
                        description:
                            'Make smart billing accessible to every business in Sri Lanka, regardless of size or location.',
                      ),
                    ),
                    SizedBox(
                      width: isMobile ? 280 : 300,
                      height: isMobile ? 220 : 240,
                      child: _StyledHoverCompanyInfoCard(
                        icon: Icons.people,
                        title: 'Our Culture',
                        description:
                            'Innovation, reliability, and customer-first approach drive everything we do.',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ===== Team Section =====
          _buildTeamSection(context),

          // ===== Values Section =====
          _buildValuesSection(context),

          // ===== Why Choose Bill Till? =====
          Container(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 40 : 60,
              horizontal: 20,
            ),
            color: Colors.white,
            child: _buildWhyChooseSection(context),
          ),
        ],
      ),
    );
  }

  static Widget _buildTeamSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 220,
                height: 280,
                child: Image.asset(
                  'assets/images/about/ceo.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade100,
                    child:
                        const Icon(Icons.person, size: 70, color: Colors.blue),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Shalitha De Soysa',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: billTill827,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Founder & CEO',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'BSC(HONS) in Computer Science, PG, CERT',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Described by clients as extremely innovative, Shalitha is the driving force behind every bespoke IT solution we design and develop.',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.grey,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            Text(
              'Our Team',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: billTill827,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'At Ceylon Innovation Services, we are more than just a service provider — we are your solution.',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildTeamMembersGrid(context),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 320,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/about/ceo.png',
                        width: 320,
                        height: 480,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, trace) {
                          return Container(
                            width: 320,
                            height: 480,
                            color: Colors.grey.shade100,
                            child: const Center(
                              child: Icon(Icons.person,
                                  size: 80, color: Colors.blue),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Shalitha De Soysa',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: billTill827,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Founder & CEO',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'BSC(HONS) in Computer Science, PG, CERT',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Described by clients as highly innovative, our team is the driving force behind every custom-built IT solution designed to scale from small to large businesses.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Our Team',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: billTill827,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'At Ceylon Innovation Services, we are more than just a service provider — we are your solution.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildTeamMembersGrid(context),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static Widget _buildTeamMembersGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final teamMembers = [
      TeamMember(
          name: 'John Smith',
          role: 'CTO',
          description: 'Technology visionary',
          imagePath: ''),
      TeamMember(
          name: 'Sarah Johnson',
          role: 'Lead Developer',
          description: 'Flutter expert',
          imagePath: ''),
      TeamMember(
          name: 'Mike Williams',
          role: 'UI/UX Designer',
          description: 'Creative designer',
          imagePath: ''),
      TeamMember(
          name: 'Emily Davis',
          role: 'Project Manager',
          description: 'Agile expert',
          imagePath: ''),
      TeamMember(
          name: 'David Brown',
          role: 'QA Engineer',
          description: 'Quality assurance',
          imagePath: ''),
      TeamMember(
          name: 'Lisa Wilson',
          role: 'Business Analyst',
          description: 'Bridging needs',
          imagePath: ''),
    ];
    final itemWidth = isMobile ? 120.0 : 150.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meet Our Experts',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.w600,
            color: billTill827,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: isMobile ? 16 : 24,
          runSpacing: isMobile ? 16 : 24,
          children: teamMembers
              .map((member) => SizedBox(
                  width: itemWidth, child: TeamMemberCircle(member: member)))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildValuesSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final cardSize = isMobile ? 220.0 : 250.0;
    final cards = [
      _ValueCardData(
          Icons.lightbulb_outline,
          'Innovation',
          'Constantly evolving to meet market needs',
          BackgroundPosition.topLeft),
      _ValueCardData(Icons.security, 'Reliability',
          'Products you can depend on every day', BackgroundPosition.topRight),
      _ValueCardData(Icons.people_alt, 'Customer First',
          'Your success is our success', BackgroundPosition.bottomLeft),
      _ValueCardData(Icons.auto_awesome, 'Simplicity',
          'Making complex tasks simple', BackgroundPosition.bottomRight),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 30 : 50,
        horizontal: 20,
      ),
      color: Colors.white,
      child: Column(
        children: [
          _sectionTitle(
            'Our Values',
            'What drives us forward',
            isMobile: isMobile,
          ),
          const SizedBox(height: 24),
          if (isMobile)
            Column(
              children: cards
                  .map((card) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: _ValueCard(
                          stepColor: Colors.blue.shade700,
                          cornerColor: billTill827,
                          icon: card.icon,
                          title: card.title,
                          description: card.description,
                          backgroundPosition: card.position,
                          width: cardSize,
                          height: cardSize,
                        ),
                      ))
                  .toList(),
            )
          else
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ValueCard(
                      stepColor: Colors.blue.shade700,
                      cornerColor: billTill827,
                      icon: cards[0].icon,
                      title: cards[0].title,
                      description: cards[0].description,
                      backgroundPosition: cards[0].position,
                      width: cardSize,
                      height: cardSize,
                    ),
                    const SizedBox(width: 24),
                    _ValueCard(
                      stepColor: Colors.blue.shade700,
                      cornerColor: billTill827,
                      icon: cards[1].icon,
                      title: cards[1].title,
                      description: cards[1].description,
                      backgroundPosition: cards[1].position,
                      width: cardSize,
                      height: cardSize,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ValueCard(
                      stepColor: Colors.blue.shade700,
                      cornerColor: billTill827,
                      icon: cards[2].icon,
                      title: cards[2].title,
                      description: cards[2].description,
                      backgroundPosition: cards[2].position,
                      width: cardSize,
                      height: cardSize,
                    ),
                    const SizedBox(width: 24),
                    _ValueCard(
                      stepColor: Colors.blue.shade700,
                      cornerColor: billTill827,
                      icon: cards[3].icon,
                      title: cards[3].title,
                      description: cards[3].description,
                      backgroundPosition: cards[3].position,
                      width: cardSize,
                      height: cardSize,
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  static Widget _sectionTitle(String title, String subtitle,
      {bool isMobile = false}) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 28 : 32,
            fontWeight: FontWeight.bold,
            color: billTill827,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 16 : 18,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildWhyChooseSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 1000;
    final isMobile = screenWidth < 768;

    if (isWide) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(right: 40, top: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Why Choose\nBill Till?',
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: billTill827,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 70, height: 500, child: _buildVerticalLine()),
              Flexible(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(left: 40, top: 20),
                  child: Column(
                    children: List.generate(
                      6,
                      (i) => _EnhancedEmergingPointCard(
                        text: [
                          'Designed for Sri Lankan business with local compliance',
                          'Works online and offline seamlessly',
                          'Affordable for all business sizes',
                          'Support in Sinhala, Tamil, and English',
                          'Regular feature updates',
                          'Minimal training required',
                        ][i],
                        index: i,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: isMobile ? 20 : 32),
          child: Column(
            children: [
              Text(
                'Why Choose Bill Till?',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 26 : 32,
                  fontWeight: FontWeight.bold,
                  color: billTill827,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: isMobile ? 260 : 300,
                child: Text(
                  'Experience the difference with our innovative billing solution for Sri Lankan businesses',
                  style: GoogleFonts.poppins(
                      fontSize: isMobile ? 15 : 16,
                      color: Colors.grey,
                      height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 50 : 70, child: _buildHorizontalLine()),
        Container(
          padding: EdgeInsets.only(
              top: isMobile ? 10 : 20, bottom: isMobile ? 20 : 30),
          child: Column(
            children: List.generate(
              6,
              (i) => _EnhancedEmergingPointCard(
                text: [
                  'For Sri Lankan businesses',
                  'Online & offline ready',
                  'Affordable plans',
                  'Local language support',
                  'Regular updates',
                  'Easy to use',
                ][i],
                index: i,
                isMobile: isMobile,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildVerticalLine() {
    return Stack(
      children: [
        Positioned(
            left: 30,
            top: 0,
            bottom: 0,
            child: Container(width: 10, color: billTillSolid)),
        Positioned(
          left: 25,
          top: 0,
          bottom: 0,
          child: Container(
            width: 18,
            decoration: BoxDecoration(
              gradient:
                  const LinearGradient(colors: [billTillSolid, billTill70]),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: billTill50, blurRadius: 12)],
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildHorizontalLine() {
    return Stack(
      children: [
        Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Container(height: 10, color: Colors.grey.withOpacity(0.2))),
        Positioned(
          top: 25,
          left: 0,
          right: 0,
          child: Container(
            height: 18,
            decoration: BoxDecoration(
              gradient:
                  const LinearGradient(colors: [billTillSolid, billTill70]),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: billTill50, blurRadius: 12)],
            ),
          ),
        ),
      ],
    );
  }
}

// =============== Reused Widgets ===============

class _StyledHoverCompanyInfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  const _StyledHoverCompanyInfoCard(
      {required this.icon, required this.title, required this.description});

  @override
  State<_StyledHoverCompanyInfoCard> createState() =>
      _StyledHoverCompanyInfoCardState();
}

class _StyledHoverCompanyInfoCardState
    extends State<_StyledHoverCompanyInfoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? billTillSolid : Colors.grey.shade300,
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                      color: billTill20,
                      blurRadius: 20,
                      offset: const Offset(0, 6))
                ]
              : [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                  color: billTillSolid, shape: BoxShape.circle),
              child: Icon(widget.icon, size: 26, color: Colors.white),
            ),
            const SizedBox(height: 14),
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                widget.description,
                style: GoogleFonts.poppins(
                    fontSize: 13, color: Colors.grey, height: 1.4),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamMember {
  final String name, role, description, imagePath;
  const TeamMember(
      {required this.name,
      required this.role,
      required this.description,
      required this.imagePath});
}

class TeamMemberCircle extends StatefulWidget {
  final TeamMember member;
  const TeamMemberCircle({super.key, required this.member});

  @override
  State<TeamMemberCircle> createState() => _TeamMemberCircleState();
}

class _TeamMemberCircleState extends State<TeamMemberCircle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            Container(
              width: _isHovered ? 110 : 100,
              height: _isHovered ? 110 : 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(55),
                border: Border.all(
                  color: _isHovered ? billTillSolid : Colors.blue.shade300,
                  width: _isHovered ? 3 : 2,
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                            color: billTill20,
                            blurRadius: 12,
                            offset: const Offset(0, 4))
                      ]
                    : [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 2))
                      ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(55),
                child: Image.asset(
                  widget.member.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, trace) => Container(
                    color: Colors.grey.shade100,
                    child:
                        const Icon(Icons.person, size: 40, color: Colors.blue),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.member.name,
              style: GoogleFonts.poppins(
                fontSize: _isHovered ? 15 : 14,
                fontWeight: FontWeight.bold,
                color: billTill827,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.member.role,
              style: GoogleFonts.poppins(
                fontSize: _isHovered ? 13 : 12,
                color: billTillSolid,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (_isHovered) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  widget.member.description,
                  style: GoogleFonts.poppins(
                      fontSize: 10, color: Colors.grey, height: 1.3),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

enum BackgroundPosition { topLeft, topRight, bottomLeft, bottomRight }

class _ValueCardData {
  final IconData icon;
  final String title;
  final String description;
  final BackgroundPosition position;
  const _ValueCardData(this.icon, this.title, this.description, this.position);
}

class _ValueCard extends StatelessWidget {
  final Color stepColor;
  final Color cornerColor;
  final IconData icon;
  final String title;
  final String description;
  final BackgroundPosition backgroundPosition;
  final double width;
  final double height;
  const _ValueCard({
    required this.stepColor,
    required this.cornerColor,
    required this.icon,
    required this.title,
    required this.description,
    required this.backgroundPosition,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          _buildBackground(),
          Container(
            width: width - 20,
            height: height - 20,
            margin: _getMargin(),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    // ✅ Fixed: no .withOpacity() — use helper
                    decoration: BoxDecoration(
                      color: _withOpacity(cornerColor, 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 30, color: cornerColor),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: billTill827),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: Colors.grey, height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    switch (backgroundPosition) {
      case BackgroundPosition.topLeft:
        return Positioned(top: 0, left: 0, child: _bg());
      case BackgroundPosition.topRight:
        return Positioned(top: 0, right: 0, child: _bg());
      case BackgroundPosition.bottomLeft:
        return Positioned(bottom: 0, left: 0, child: _bg());
      case BackgroundPosition.bottomRight:
        return Positioned(bottom: 0, right: 0, child: _bg());
    }
  }

  Widget _bg() => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: cornerColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            // ✅ Fixed: no .withOpacity()
            BoxShadow(
              color: _withOpacity(cornerColor, 0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
      );

  EdgeInsets _getMargin() {
    switch (backgroundPosition) {
      case BackgroundPosition.topLeft:
        return const EdgeInsets.only(top: 20, left: 20);
      case BackgroundPosition.topRight:
        return const EdgeInsets.only(top: 20, right: 20);
      case BackgroundPosition.bottomLeft:
        return const EdgeInsets.only(bottom: 20, left: 20);
      case BackgroundPosition.bottomRight:
        return const EdgeInsets.only(bottom: 20, right: 20);
    }
  }
}

class _EnhancedEmergingPointCard extends StatefulWidget {
  final String text;
  final int index;
  final bool isMobile;
  const _EnhancedEmergingPointCard(
      {required this.text, required this.index, this.isMobile = false});

  @override
  State<_EnhancedEmergingPointCard> createState() =>
      _EnhancedEmergingPointCardState();
}

class _EnhancedEmergingPointCardState extends State<_EnhancedEmergingPointCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation, _opacityAnimation, _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 800 + widget.index * 150),
        vsync: this);
    _slideAnimation = Tween<double>(begin: -60, end: 0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _opacityAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 300 + widget.index * 150), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_slideAnimation.value, 0),
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: widget.isMobile ? 12 : 18),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                                color: billTill15,
                                blurRadius: 15,
                                offset: const Offset(0, 6))
                          ]
                        : [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4))
                          ],
                    border: Border.all(
                      color: _isHovered ? billTillSolid : Colors.grey.shade200,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        margin: const EdgeInsets.only(right: 14, top: 4),
                        decoration: const BoxDecoration(
                            color: billTillSolid, shape: BoxShape.circle),
                      ),
                      Expanded(
                        child: Text(
                          widget.text,
                          style: GoogleFonts.poppins(
                              fontSize: widget.isMobile ? 14 : 15,
                              color: Colors.grey.shade800,
                              height: 1.4,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
