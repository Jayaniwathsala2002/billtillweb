// lib/sections/features_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Our Features',
            style: GoogleFonts.poppins(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0B0655),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Simple, reliable, and built for your business.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xFF555555),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          const Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 24,
            runSpacing: 40,
            children: [
              _FeatureCard(
                title: 'Point of Sale (POS)',
                description:
                    'Fast, intuitive checkout with receipt printing and real-time payment tracking.',
                icon: Icons.point_of_sale_outlined,
              ),
              _FeatureCard(
                title: 'Inventory Management',
                description:
                    'Track stock levels, get low-stock alerts, and scan barcodes in seconds.',
                icon: Icons.inventory_2_outlined,
              ),
              _FeatureCard(
                title: 'Business Reports',
                description:
                    'Generate sales, profit, and tax reports. Export to PDF or Excel instantly.',
                icon: Icons.bar_chart_outlined,
              ),
              _FeatureCard(
                title: 'Data Security',
                description:
                    'Bank-grade encryption, role-based access, and automatic cloud backups.',
                icon: Icons.lock_outlined,
              ),
            ],
          ),
          const SizedBox(height: 70),
          Text(
            'Built for Every Business',
            style: GoogleFonts.poppins(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0B0655),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'From retail stores to car rentals — Bill Till adapts to your needs.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xFF555555),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          const Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 24,
            runSpacing: 32,
            children: [
              _IndustryCard(
                name: 'Retail Solutions',
                image: 'assets/images/product/Product1.jpeg',
                shortDesc: 'Manage sales, inventory & customers with ease.',
                iconData: Icons.store_outlined,
              ),
              _IndustryCard(
                name: 'Restaurant Systems',
                image: 'assets/images/product/Product2.jpeg',
                shortDesc: 'Streamline orders, table management, and payments.',
                iconData: Icons.restaurant_outlined,
              ),
              _IndustryCard(
                name: 'Rent-a-Car Software',
                image: 'assets/images/product/Product3.jpeg',
                shortDesc:
                    'Track vehicles, manage bookings, and handle agreements.',
                iconData: Icons.directions_car_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _FeatureCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: const BoxDecoration(
              color: Color(0xFFf0f4ff),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 28,
              color: const Color(0xFF0B0655),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0B0655),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF555555),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _IndustryCard extends StatefulWidget {
  final String name;
  final String image;
  final String shortDesc;
  final IconData iconData;

  const _IndustryCard({
    required this.name,
    required this.image,
    required this.shortDesc,
    required this.iconData,
  });

  @override
  State<_IndustryCard> createState() => _IndustryCardState();
}

class _IndustryCardState extends State<_IndustryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: SizedBox(
              width: 280,
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color.fromRGBO(0, 0, 0, 0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                widget.iconData,
                                size: 18,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.shortDesc,
                            style: const TextStyle(
                              fontSize: 13,
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
        },
      ),
    );
  }
}
