import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'About Us',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: const Color.fromRGBO(11, 6, 85, 0.827),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Bill Till is a product of Ceylon Innovation Services (PVT) LTD',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 40),
          const Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
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

          // === NEW: CEO Section Below (Properly Scaled Image) ===
          const SizedBox(height: 60),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image.asset(
                        'assets/images/about/ceo.png',
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.blue.shade50,
                            child: const Center(
                              child: Icon(Icons.person,
                                  size: 60, color: Colors.blue),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 40),
              // CEO Info & Team Members
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Described by clients as extremely innovative, Shalitha is the driving force behind every bespoke IT solution we design and develop.',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Our Team',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(11, 6, 85, 0.827),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'At Ceylon Innovation Services, we are more than just a service provider — we are your solution.',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.blue.shade700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Meet Our Experts',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Team Members Row with Animation on Hover
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => _AnimatedTeamMemberCard(
                          name: _teamNames[index],
                          role: _teamRoles[index],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Shalitha De Soysa',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(11, 6, 85, 0.827),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Founder & CEO',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'BSC (HONS) in Computer Science, PG, CERT',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- Animated Team Member Card ---
class _AnimatedTeamMemberCard extends StatefulWidget {
  final String name;
  final String role;

  const _AnimatedTeamMemberCard({
    Key? key,
    required this.name,
    required this.role,
  }) : super(key: key);

  @override
  State<_AnimatedTeamMemberCard> createState() =>
      _AnimatedTeamMemberCardState();
}

class _AnimatedTeamMemberCardState extends State<_AnimatedTeamMemberCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _borderWidthAnimation;
  late Animation<Color?> _borderColorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _borderWidthAnimation = Tween<double>(begin: 2.0, end: 3.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _borderColorAnimation = ColorTween(
      begin: Colors.blue.shade200,
      end: Colors.blue.shade400,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: 80,
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade50,
                  border: Border.all(
                    color: _borderColorAnimation.value ?? Colors.blue.shade200,
                    width: _borderWidthAnimation.value,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: Colors.blue.shade300.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child:
                    Icon(Icons.person, color: Colors.blue.shade700, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                widget.name,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                widget.role,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.blue.shade700,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Dummy Data for Team Members ---
const List<String> _teamNames = [
  'John Smith',
  'Sarah Johnson',
  'Mike Williams',
  'Emily Davis',
  'David Brown',
  'Lisa Wilson',
];

const List<String> _teamRoles = [
  'CTO',
  'Lead Developer',
  'UI/UX Designer',
  'Project Manager',
  'QA Engineer',
  'Business Analyst',
];

// --- Existing Styled Hover Card ---
class _StyledHoverCompanyInfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const _StyledHoverCompanyInfoCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

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
        width: 320,
        height: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? Colors.blue.shade400 : Colors.grey.shade300,
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.blue.shade300.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  const BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          children: [
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: -25,
                    child: SizedBox(
                      height: 70,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const CustomPaint(
                            size: Size(100, 70),
                            painter:
                                _ImageStylePentagonPainter(color: Colors.white),
                          ),
                          CustomPaint(
                            size: const Size(50, 50),
                            painter: _ImageStylePentagonPainter(
                                color: Colors.blue.shade700),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(
                                widget.icon,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        widget.title,
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.description,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
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
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final double width = size.width;
    final double height = size.height;
    final double centerX = width / 2;
    final Path path = Path();
    path.moveTo(centerX, 0);
    path.lineTo(centerX - width * 0.4, height * 0.35);
    path.lineTo(centerX - width * 0.3, height);
    path.lineTo(centerX + width * 0.3, height);
    path.lineTo(centerX + width * 0.4, height * 0.35);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
