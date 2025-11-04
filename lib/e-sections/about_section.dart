import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Bill Till Brand Color: #0B0655 → R:11, G:6, B:85
Color billTillWithOpacity(double opacity) => Color.fromRGBO(11, 6, 85, opacity);

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ===== About Us — No Background =====
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'About Us',
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: billTillWithOpacity(0.827),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Bill Till is a product of Ceylon Innovation Services (PVT) LTD',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 32,
                runSpacing: 32,
                alignment: WrapAlignment.center,
                children: const [
                  _StyledHoverCompanyInfoCard(
                    icon: Icons.history,
                    title: 'Our Story',
                    description:
                        'Founded to solve billing challenges faced by Sri Lankan businesses with innovative technology solutions.',
                  ),
                  _StyledHoverCompanyInfoCard(
                    icon: Icons.flag,
                    title: 'Our Mission',
                    description:
                        'Make smart billing accessible to every business in Sri Lanka, regardless of size or location.',
                  ),
                  _StyledHoverCompanyInfoCard(
                    icon: Icons.people,
                    title: 'Our Culture',
                    description:
                        'Innovation, reliability, and customer-first approach drive everything we do.',
                  ),
                ],
              ),
            ],
          ),
        ),

        // ===== Team Section =====
        Container(color: Colors.white, child: _buildTeamSection(context)),

        // ===== Values Section =====
        _buildValuesSection(context),

        // ===== Why Choose Bill Till? =====
        Container(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          color: Colors.grey.shade50,
          child: _buildWhyChooseSection(context),
        ),
      ],
    );
  }

  static Widget _buildTeamSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              width: 280,
              height: 400,
              child: Image.asset(
                'assets/images/about/ceo.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade100,
                  child: const Icon(Icons.person, size: 80, color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Shalitha De Soysa',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: billTillWithOpacity(0.827),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Founder & CEO',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'BSC(HONS) in Computer Science, PG, CERT',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              'Described by clients as extremely innovative, Shalitha is the driving force behind every bespoke IT solution we design and develop.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Our Team',
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: billTillWithOpacity(0.827),
              ),
              textAlign: TextAlign.center,
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
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildTeamMembersGrid(context),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 400,
                  margin: const EdgeInsets.only(right: 40),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/about/ceo.png',
                        width: 380,
                        height: 650,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, trace) {
                          return Container(
                            width: 380,
                            height: 650,
                            color: Colors.grey.shade100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.person,
                                    size: 80, color: Colors.blue),
                                const SizedBox(height: 10),
                                const Text('Image not found',
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Shalitha De Soysa',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: billTillWithOpacity(0.827),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Founder & CEO',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'BSC(HONS) in Computer Science, PG, CERT',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 40, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Described by clients as extremely innovative, Shalitha is the driving force behind every bespoke IT solution we design and develop.',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Our Team',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: billTillWithOpacity(0.827),
                          ),
                        ),
                        const SizedBox(height: 16),
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
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildTeamMembersGrid(BuildContext context) {
    final teamMembers = [
      TeamMember(
          name: 'John Smith',
          role: 'CTO',
          description: 'Technology visionary',
          imagePath: 'assets/images/team1.jpg'),
      TeamMember(
          name: 'Sarah Johnson',
          role: 'Lead Developer',
          description: 'Flutter expert',
          imagePath: 'assets/images/team2.jpg'),
      TeamMember(
          name: 'Mike Williams',
          role: 'UI/UX Designer',
          description: 'Creative designer',
          imagePath: 'assets/images/team3.jpg'),
      TeamMember(
          name: 'Emily Davis',
          role: 'Project Manager',
          description: 'Agile expert',
          imagePath: 'assets/images/team4.jpg'),
      TeamMember(
          name: 'David Brown',
          role: 'QA Engineer',
          description: 'Quality assurance',
          imagePath: 'assets/images/team5.jpg'),
      TeamMember(
          name: 'Lisa Wilson',
          role: 'Business Analyst',
          description: 'Bridging needs',
          imagePath: 'assets/images/team6.jpg'),
    ];
    final itemWidth = MediaQuery.of(context).size.width < 600 ? 140.0 : 160.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meet Our Experts',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: billTillWithOpacity(0.827),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 28,
          runSpacing: 28,
          children: teamMembers
              .map((member) => SizedBox(
                  width: itemWidth, child: TeamMemberCircle(member: member)))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildValuesSection(BuildContext context) {
    const double cardSize = 280.0;
    final isMobile = MediaQuery.of(context).size.width < 768;
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

    if (isMobile) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        color: Colors.blue.shade50,
        child: Column(
          children: [
            _sectionTitle('Our Values', 'What drives us forward'),
            const SizedBox(height: 40),
            for (var card in cards)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _ValueCard(
                  stepColor: Colors.blue.shade700,
                  cornerColor: billTillWithOpacity(0.827),
                  icon: card.icon,
                  title: card.title,
                  description: card.description,
                  backgroundPosition: card.position,
                  width: cardSize,
                  height: cardSize,
                ),
              ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: Colors.blue.shade50,
      child: Column(
        children: [
          _sectionTitle('Our Values', 'What drives us forward'),
          const SizedBox(height: 40),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _ValueCard(
                stepColor: Colors.blue.shade700,
                cornerColor: billTillWithOpacity(0.827),
                icon: cards[0].icon,
                title: cards[0].title,
                description: cards[0].description,
                backgroundPosition: cards[0].position,
                width: cardSize,
                height: cardSize),
            const SizedBox(width: 32),
            _ValueCard(
                stepColor: Colors.blue.shade700,
                cornerColor: billTillWithOpacity(0.827),
                icon: cards[1].icon,
                title: cards[1].title,
                description: cards[1].description,
                backgroundPosition: cards[1].position,
                width: cardSize,
                height: cardSize),
          ]),
          const SizedBox(height: 32),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _ValueCard(
                stepColor: Colors.blue.shade700,
                cornerColor: billTillWithOpacity(0.827),
                icon: cards[2].icon,
                title: cards[2].title,
                description: cards[2].description,
                backgroundPosition: cards[2].position,
                width: cardSize,
                height: cardSize),
            const SizedBox(width: 32),
            _ValueCard(
                stepColor: Colors.blue.shade700,
                cornerColor: billTillWithOpacity(0.827),
                icon: cards[3].icon,
                title: cards[3].title,
                description: cards[3].description,
                backgroundPosition: cards[3].position,
                width: cardSize,
                height: cardSize),
          ]),
        ],
      ),
    );
  }

  static Widget _sectionTitle(String title, String subtitle) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: billTillWithOpacity(0.827)),
        ),
        const SizedBox(height: 8),
        Text(subtitle,
            style:
                GoogleFonts.poppins(fontSize: 18, color: Colors.grey.shade600)),
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
                            color: Colors.blue.shade800,
                            height: 1.2),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 70, height: 550, child: _buildVerticalLine()),
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
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            children: [
              Text(
                'Why Choose Bill Till?',
                style: GoogleFonts.poppins(
                    fontSize: isMobile ? 28 : 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: isMobile ? 280 : 300,
                child: Text(
                  'Experience the difference with our innovative billing solution for Sri Lankan businesses',
                  style: GoogleFonts.poppins(
                      fontSize: 16, color: Colors.grey.shade600, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 70, child: _buildHorizontalLine()),
        Container(
          padding: const EdgeInsets.only(top: 20),
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
            child: Container(width: 10, color: Colors.blue.shade600)),
        Positioned(
          left: 25,
          top: 0,
          bottom: 0,
          child: Container(
            width: 18,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.blueAccent]),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.blue.shade900.withOpacity(0.5),
                    blurRadius: 12)
              ],
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
              gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.blueAccent]),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.blue.shade900.withOpacity(0.5),
                    blurRadius: 12)
              ],
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
        width: 310,
        height: 310,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: _isHovered ? Colors.blue.shade400 : Colors.grey.shade300,
              width: _isHovered ? 2 : 1),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                      color: Colors.blue.shade200,
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
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFF0B0655),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: -22,
                    child: Container(
                      height: 60,
                      child: Stack(
                        alignment: Alignment.center,
                        children: const [
                          CustomPaint(
                              size: Size(90, 60),
                              painter: _ImageStylePentagonPainter(
                                  color: Colors.white)),
                          CustomPaint(
                              size: Size(45, 45),
                              painter: _ImageStylePentagonPainter(
                                  color: Colors.white),
                              child: Icon(Icons.lightbulb,
                                  size: 22, color: Color(0xFF0B0655))),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 35,
                    child: Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  widget.description,
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: Colors.grey.shade700, height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageStylePentagonPainter extends CustomPainter {
  final Color color;
  const _ImageStylePentagonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final path = Path()
      ..moveTo(cx, 0)
      ..lineTo(cx - w * 0.4, h * 0.35)
      ..lineTo(cx - w * 0.3, h)
      ..lineTo(cx + w * 0.3, h)
      ..lineTo(cx + w * 0.4, h * 0.35)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
        width: 160,
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Container(
              width: _isHovered ? 130 : 120,
              height: _isHovered ? 130 : 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75),
                border: Border.all(
                    color: _isHovered
                        ? Colors.blue.shade400
                        : Colors.blue.shade300,
                    width: _isHovered ? 3 : 2),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                            color: Colors.blue.shade200,
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
                borderRadius: BorderRadius.circular(75),
                child: Image.asset(
                  widget.member.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, trace) => Container(
                    color: Colors.grey.shade100,
                    child:
                        const Icon(Icons.person, size: 48, color: Colors.blue),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.member.name,
              style: GoogleFonts.poppins(
                fontSize: _isHovered ? 16 : 15,
                fontWeight: FontWeight.bold,
                color: billTillWithOpacity(0.827),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.member.role,
              style: GoogleFonts.poppins(
                fontSize: _isHovered ? 14 : 13,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (_isHovered) ...[
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.member.description,
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: Colors.grey.shade600, height: 1.3),
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
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        color: cornerColor.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: Icon(icon, size: 32, color: cornerColor),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: billTillWithOpacity(0.827)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: Colors.grey.shade600, height: 1.4),
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
            BoxShadow(
                color: cornerColor.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6))
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
  const _EnhancedEmergingPointCard({required this.text, required this.index});

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
                  margin: const EdgeInsets.only(bottom: 18),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                                color: Colors.blue.shade100,
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
                        color: _isHovered
                            ? Colors.blue.shade300
                            : Colors.grey.shade200,
                        width: 1.2),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        margin: const EdgeInsets.only(right: 14, top: 4),
                        decoration: BoxDecoration(
                            color: const Color(0xFF0B0655),
                            shape: BoxShape.circle),
                      ),
                      Expanded(
                        child: Text(
                          widget.text,
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.grey.shade800,
                              height: 1.5,
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
