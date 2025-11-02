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
    setState(() {
      _hoveredIndex = index;
    });
  }

  void _showPartnerForm() {
    // Placeholder - in a real app, this would show the partner signup form dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Partner form will open here!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero Section for Partner Page
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade50,
                Colors.white,
                Colors.blue.shade50,
              ],
            ),
          ),
          child: Column(
            children: [
              Text(
                'Join Our Partner Program',
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0B0655).withOpacity(0.827),
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Build your business while helping others grow theirs',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _showPartnerForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Become a Partner Today'),
              ),
            ],
          ),
        ),

        // Partner Models Section
        Container(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          child: Column(
            children: [
              Text(
                'Choose Your Partner Model',
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0B0655).withOpacity(0.827),
                ),
              ),
              const SizedBox(height: 40),
              _PartnerSection(
                hoveredIndex: _hoveredIndex,
                onHoverChanged: _handleHover,
              ),
            ],
          ),
        ),

        // Partner Benefits Section - RESTORED TO ORIGINAL SIZE
        Container(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          color: Colors.white,
          child: Column(
            children: [
              Text(
                'Why Partner With Us?',
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0B0655).withOpacity(0.827),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  children: [
                    Text(
                      'Partner Benefits',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0B0655).withOpacity(0.827),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Benefits Items with staggered animation - ORIGINAL SIZE
                    Wrap(
                      spacing: 30,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: [
                        _BenefitItem(
                          icon: Icons.attach_money,
                          title: 'Lifetime Commission',
                          description:
                              'Earn ongoing commissions from your referrals',
                          animationDelay: 100,
                        ),
                        _BenefitItem(
                          icon: Icons.school,
                          title: 'Training',
                          description:
                              'Comprehensive product and sales training',
                          animationDelay: 200,
                        ),
                        _BenefitItem(
                          icon: Icons.support_agent,
                          title: 'Support',
                          description: 'Dedicated partner support team',
                          animationDelay: 300,
                        ),
                        _BenefitItem(
                          icon: Icons.rocket_launch,
                          title: 'Marketing',
                          description:
                              'Marketing materials and lead generation support',
                          animationDelay: 400,
                        ),
                        _BenefitItem(
                          icon: Icons.people,
                          title: 'Community',
                          description:
                              'Join our network of successful partners',
                          animationDelay: 500,
                        ),
                        _BenefitItem(
                          icon: Icons.trending_up,
                          title: 'Growth',
                          description:
                              'Scalable business with unlimited potential',
                          animationDelay: 600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // FAQ Section
        Container(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          color: Colors.grey.shade50,
          child: Column(
            children: [
              Text(
                'Frequently Asked Questions',
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0B0655).withOpacity(0.827),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 800,
                child: Column(
                  children: const [
                    _FAQItem(
                      question: 'How much investment is required?',
                      answer:
                          'No upfront investment required for Independent Brokers. City Franchise requires a minimal security deposit which is refundable.',
                    ),
                    _FAQItem(
                      question: 'What training will I receive?',
                      answer:
                          'Comprehensive training on our products, sales techniques, and customer support. Ongoing training for new features and updates.',
                    ),
                    _FAQItem(
                      question: 'How are commissions paid?',
                      answer:
                          'Commissions are paid monthly via bank transfer. You can track your earnings in real-time through our partner portal.',
                    ),
                    _FAQItem(
                      question: 'Is there territory protection?',
                      answer:
                          'Yes, City Franchise partners get exclusive territory rights. Independent Brokers can operate anywhere.',
                    ),
                    _FAQItem(
                      question: 'What support is provided?',
                      answer:
                          '24/7 technical support, marketing materials, lead generation support, and dedicated account management.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Partner Section Widget
class _PartnerSection extends StatelessWidget {
  final int? hoveredIndex;
  final Function(int?) onHoverChanged;

  const _PartnerSection({
    required this.hoveredIndex,
    required this.onHoverChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AnimatedPartnerModel(
          title: 'City Franchise',
          description:
              'Exclusive rights for your city or region with comprehensive support',
          benefits: [
            'Exclusive territory rights',
            'Higher commission rates',
            'Marketing support',
            'Training and certification',
            'Dedicated account manager',
            'Priority lead generation',
          ],
          commission: 'Up to 25% commission',
          investment: 'Minimal security deposit',
          isExpanded: hoveredIndex == 0,
          isSelected: hoveredIndex == 0,
          onHover: (isHovering) => onHoverChanged(isHovering ? 0 : null),
          index: 0,
          hoveredIndex: hoveredIndex,
        ),
        const SizedBox(height: 30),
        _AnimatedPartnerModel(
          title: 'Independent Broker',
          description: 'Flexible partnership with no territory restrictions',
          benefits: [
            'Lifetime commission',
            'Flexible working hours',
            'Sales training',
            'Marketing materials',
            'No territory limits',
            'Work from anywhere',
          ],
          commission: '15% lifetime commission',
          investment: 'No investment required',
          isExpanded: hoveredIndex == 1,
          isSelected: hoveredIndex == 1,
          onHover: (isHovering) => onHoverChanged(isHovering ? 1 : null),
          index: 1,
          hoveredIndex: hoveredIndex,
        ),
      ],
    );
  }
}

// Animated Partner Model Widget
class _AnimatedPartnerModel extends StatelessWidget {
  final String title;
  final String description;
  final List<String> benefits;
  final String commission;
  final String investment;
  final bool isExpanded;
  final bool isSelected;
  final Function(bool) onHover;
  final int index;
  final int? hoveredIndex;

  const _AnimatedPartnerModel({
    required this.title,
    required this.description,
    required this.benefits,
    required this.commission,
    required this.investment,
    required this.isExpanded,
    required this.isSelected,
    required this.onHover,
    required this.index,
    required this.hoveredIndex,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAnyCardHovered = hoveredIndex != null;
    final bool isThisCardHovered = hoveredIndex == index;
    final bool isOtherCardHovered = isAnyCardHovered && !isThisCardHovered;

    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: isMobile
            ? MediaQuery.of(context).size.width * 0.95
            : MediaQuery.of(context).size.width * 0.7,
        height: isExpanded ? (isMobile ? 560 : 420) : (isMobile ? 540 : 400),
        padding: isMobile ? const EdgeInsets.all(16) : const EdgeInsets.all(20),
        margin: EdgeInsets.only(
          bottom: isThisCardHovered ? 15 : 0,
          top: isOtherCardHovered ? 30 : 0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.blue.shade400 : Colors.blue.shade200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.blue.shade100.withOpacity(0.6),
                blurRadius: 20,
                spreadRadius: 3,
                offset: const Offset(0, 10),
              )
            else
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0B0655).withOpacity(0.827),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Commission and Investment
            Column(
              children: [
                Text(
                  commission,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 18 : 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  investment,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: isMobile ? 14 : 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Description
            SizedBox(
              width: isMobile
                  ? MediaQuery.of(context).size.width * 0.9
                  : MediaQuery.of(context).size.width * 0.8,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Benefits
            Expanded(
              child:
                  isMobile ? _buildMobileBenefits() : _buildDesktopBenefits(),
            ),

            const SizedBox(height: 12),

            // CTA Button
            SizedBox(
              width: isMobile
                  ? MediaQuery.of(context).size.width * 0.7
                  : MediaQuery.of(context).size.width * 0.5,
              height: isMobile ? 45 : 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Application for $title will open soon!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Apply for $title',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 16 : 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Desktop layout
  Widget _buildDesktopBenefits() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // First row of benefits (3 items)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: benefits
              .sublist(0, 3)
              .map((benefit) => _BenefitListItem(
                    benefit: benefit,
                    isMobile: false,
                  ))
              .toList(),
        ),
        // Second row of benefits (3 items)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: benefits
              .sublist(3, 6)
              .map((benefit) => _BenefitListItem(
                    benefit: benefit,
                    isMobile: false,
                  ))
              .toList(),
        ),
      ],
    );
  }

  // Mobile layout
  Widget _buildMobileBenefits() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: benefits.length,
      itemBuilder: (context, index) {
        return _BenefitListItem(
          benefit: benefits[index],
          isMobile: true,
        );
      },
    );
  }
}

// Benefit List Item Widget
class _BenefitListItem extends StatelessWidget {
  final String benefit;
  final bool isMobile;

  const _BenefitListItem({
    required this.benefit,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green.shade600,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                benefit,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green.shade600,
              size: 22,
            ),
            const SizedBox(width: 6),
            Text(
              benefit,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }
  }
}

// Benefit Item Widget (for the "Why Partner With Us?" section)
class _BenefitItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final int animationDelay;

  const _BenefitItem({
    required this.icon,
    required this.title,
    required this.description,
    this.animationDelay = 0,
  });

  @override
  State<_BenefitItem> createState() => __BenefitItemState();
}

class __BenefitItemState extends State<_BenefitItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    Future.delayed(
      Duration(milliseconds: widget.animationDelay),
      () {
        if (mounted) {
          _controller.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value * (_isHovered ? 1.05 : 1.0),
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: SlideTransition(
                position: _slideAnimation,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: isMobile
                      ? const EdgeInsets.all(16)
                      : const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? Colors.blue.shade100.withOpacity(0.3)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: Colors.blue.shade100.withOpacity(0.3),
                              blurRadius: 15,
                            )
                          ]
                        : [],
                  ),
                  child: SizedBox(
                    width: isMobile ? 160 : 220,
                    child: Column(
                      children: [
                        Icon(
                          widget.icon,
                          size: isMobile ? 40 : 52,
                          color: _isHovered
                              ? Colors.blue.shade700
                              : Colors.blue.shade600,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.title,
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 16 : 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.description,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: isMobile ? 14 : 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
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

// FAQ Item Widget
class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQItem({
    required this.question,
    required this.answer,
  });

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade800,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.answer,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: isMobile ? 13 : 14,
                height: 1.6,
              ),
            ),
          ),
        ],
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
      ),
    );
  }
}
