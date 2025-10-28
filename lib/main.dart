import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'sections/home_section.dart';
import 'sections/features_section.dart';
import 'sections/pricing_section.dart';
import 'sections/partners_section.dart';
import 'sections/business_section.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'widgets/navbar.dart';

void main() {
  runApp(const BillTillWeb());
}

class BillTillWeb extends StatelessWidget {
  const BillTillWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ItemScrollController _scrollController = ItemScrollController();
  int _activeIndex = 0; // ← Add this

  void scrollTo(int index) {
    setState(() {
      _activeIndex = index; // ← Track active section
    });
    _scrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 992;

    return Scaffold(
      body: Stack(
        children: [
          ScrollablePositionedList.builder(
            itemScrollController: _scrollController,
            itemCount: 7,
            itemBuilder: (context, index) {
              switch (index) {
                // Inside itemBuilder
                case 0:
                  return HomeSection(
                    isMobile: isMobile,
                    onInvoiceTap: () {
                      // Open web invoice generator
                    },
                    onViewPricingTap: () {
                      // Scroll to pricing section
                    },
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
              activeIndex: _activeIndex, // ← Pass active index
            ),
          ),
        ],
      ),
    );
  }
}
