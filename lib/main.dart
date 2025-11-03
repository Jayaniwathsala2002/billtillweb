// lib/main.dart
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'sections/home_section.dart';
import 'sections/features_section.dart';
import 'sections/pricing_section.dart';
import 'sections/partners_section.dart';
import 'sections/business_section.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';
import 'widgets/navbar.dart';

void main() {
  runApp(const BillTillWeb());
}

class BillTillWeb extends StatelessWidget {
  const BillTillWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _positionsListener =
      ItemPositionsListener.create();
  int _activeIndex = 0;

  void scrollTo(int index) {
    // Prevent scrolling to footer (index 7) via navbar
    if (index >= 7) return;
    setState(() => _activeIndex = index);
    _scrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _positionsListener.itemPositions.addListener(_updateActiveIndex);
  }

  @override
  void dispose() {
    _positionsListener.itemPositions.removeListener(_updateActiveIndex);
    super.dispose();
  }

  void _updateActiveIndex() {
    final positions = _positionsListener.itemPositions.value;
    if (positions.isEmpty) return;

    final first = positions.firstWhere(
      (pos) => pos.itemLeadingEdge >= 0,
      orElse: () => positions.firstWhere(
        (pos) => pos.itemTrailingEdge > 0,
        orElse: () => positions.first,
      ),
    );

    // 🔹 Only allow activeIndex from 0 to 6 (footer is index 7, ignore it)
    int newIndex = first.index;
    if (newIndex > 6) {
      newIndex = 6; // Keep "Contact" active when in footer
    }

    if (newIndex != _activeIndex) {
      setState(() => _activeIndex = newIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 992;

    return Scaffold(
      body: Stack(
        children: [
          ScrollablePositionedList.builder(
            itemScrollController: _scrollController,
            itemPositionsListener: _positionsListener,
            itemCount: 8, // ✅ Updated: 0 to 7 = 8 items
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return HomeSection(
                    isMobile: isMobile,
                    onInvoiceTap: () {},
                    onViewPricingTap: () => scrollTo(2),
                  );
                case 1:
                  return const FeaturesSection();
                case 2:
                  return const PricingSection();
                case 3:
                  return const PartnersSection();
                case 4:
                  return const BusinessSection();
                case 5:
                  return const AboutSection();
                case 6:
                  return const ContactSection();
                case 7:
                  return const FooterSection(); // ✅ Footer at the end
                default:
                  return const SizedBox();
              }
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              onItemSelected: scrollTo,
              activeIndex: _activeIndex,
            ),
          ),
        ],
      ),
    );
  }
}
