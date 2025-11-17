import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'எங்கள் அம்சங்கள்',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 32 : 42,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF170069),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'எளிமையானது, நம்பகமானது, மற்றும் உங்கள் வியாபாரத்திற்கு உருவாக்கப்பட்டது.',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: const Color(0xFF555555),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: isMobile ? 12 : 24,
            runSpacing: isMobile ? 30 : 40,
            children: const [
              _FeatureCard(
                title: 'விலைபேச்சு புள்ளி (POS)',
                description:
                    'வேகமான, உணர்வுப்பூர்வமான செக் அவுட், ரசீது அச்சிடுதல் மற்றும் நேரடி செலுத்தல் கண்காணிப்பு.',
                icon: Icons.point_of_sale_outlined,
                isMobile: false,
              ),
              _FeatureCard(
                title: 'பொருட்களின் நிர்வாகம்',
                description:
                    'பங்கு நிலைகளை கண்காணிக்கவும், குறைந்த பங்கு எச்சரிக்கைகளை பெறவும், சில வினாடிகளுக்குள் பார்கோட்களை ஸ்கேன் செய்யவும்.',
                icon: Icons.inventory_2_outlined,
                isMobile: false,
              ),
              _FeatureCard(
                title: 'வணிக அறிக்கை',
                description:
                    'விற்பனை, லாபம் மற்றும் வரி அறிக்கைகளைக் உருவாக்குதல். உடனடியாக PDF அல்லது எக்செல் வடிவத்தில் ஏற்றுமதி செய்யவும்.',
                icon: Icons.bar_chart_outlined,
                isMobile: false,
              ),
              _FeatureCard(
                title: 'தரவு பாதுகாப்பு',
                description:
                    'வங்கி நிலை குறியாக்கம், வேடப் பாவனை அடிப்படையிலான அணுகல், மற்றும் தானாகக் கிளவுட் காப்புப்பெருக்கல்கள்.',
                icon: Icons.lock_outlined,
                isMobile: false,
              ),
            ],
          ),
          const SizedBox(height: 70),
          Text(
            'ஒவ்வொரு வணிகத்திற்கும் உருவாக்கப்பட்டது',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 32 : 42,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF170069),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'சில்லறை கடைகளிலிருந்து கார் வாடகை சேவைகள் வரை – பில் டில் உங்கள் தேவைகளுக்கு ஏற்ப ஒருங்கினைக்கிறது.',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: const Color(0xFF555555),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: isMobile ? 12 : 24,
            runSpacing: isMobile ? 24 : 30,
            children: const [
              _IndustryCard(
                name: 'ரீட்டெயில் தீர்வுகள்',
                image: 'assets/images/product/Product1.jpeg',
                shortDesc:
                    'விற்பனை, கையிருப்பு மற்றும் வாடிக்கையாளர்களைக் எளிதாக கையாளுங்கள்.',
                iconData: Icons.store_outlined,
              ),
              _IndustryCard(
                name: 'உணவக அமைப்புகள்',
                image: 'assets/images/product/Product2.jpeg',
                shortDesc:
                    'ஆணைகள், மேசை மேலாண்மை மற்றும் பணம் பரிமாற்றங்களை சீரமைக்கவும்.',
                iconData: Icons.restaurant_outlined,
              ),
              _IndustryCard(
                name: 'வேலைக்கு கார் வாடகை மென்பொருள்',
                image: 'assets/images/product/Product3.jpeg',
                shortDesc:
                    'வாகனங்களை கண்காணிக்கவும், முன்பதிவுகளை நிர்வகிக்கவும் மற்றும் உடன்படிக்கைகளை கையாளவும்.',
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
  final bool isMobile;

  const _FeatureCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final bool actualIsMobile = MediaQuery.of(context).size.width < 600;

    return SizedBox(
      width: actualIsMobile ? 260 : 280,
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
              color: const Color(0xFF170069),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: actualIsMobile ? 15 : 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF170069),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: actualIsMobile ? 12 : 13,
              color: const Color(0xFF555555),
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
              width: MediaQuery.of(context).size.width < 600 ? 260 : 280,
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
