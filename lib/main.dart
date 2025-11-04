// lib/main.dart
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'language_manager.dart';
import 'widgets/navbar.dart';

// Import sections with ALIASES
import 'e-sections/home_section.dart' as en_home;
import 'e-sections/features_section.dart' as en_features;
import 'e-sections/pricing_section.dart' as en_pricing;
import 'e-sections/partners_section.dart' as en_partners;
import 'e-sections/business_section.dart' as en_business;
import 'e-sections/about_section.dart' as en_about;
import 'e-sections/contact_section.dart' as en_contact;
import 'e-sections/footer_section.dart' as en_footer;

import 's-sections/home_section.dart' as si_home;
import 's-sections/features_section.dart' as si_features;
import 's-sections/pricing_section.dart' as si_pricing;
import 's-sections/partners_section.dart' as si_partners;
import 's-sections/business_section.dart' as si_business;
import 's-sections/about_section.dart' as si_about;
import 's-sections/contact_section.dart' as si_contact;
import 's-sections/footer_section.dart' as si_footer;

import 't-sections/home_section.dart' as ta_home;
import 't-sections/features_section.dart' as ta_features;
import 't-sections/pricing_section.dart' as ta_pricing;
import 't-sections/partners_section.dart' as ta_partners;
import 't-sections/business_section.dart' as ta_business;
import 't-sections/about_section.dart' as ta_about;
import 't-sections/contact_section.dart' as ta_contact;
import 't-sections/footer_section.dart' as ta_footer;

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
  AppLanguage _currentLanguage = AppLanguage.english;

  void scrollTo(int index) {
    if (index >= 7) return;
    setState(() => _activeIndex = index);
    _scrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _onLanguageSelected(String langName) {
    AppLanguage lang;
    switch (langName) {
      case 'Sinhala':
        lang = AppLanguage.sinhala;
        break;
      case 'Tamil':
        lang = AppLanguage.tamil;
        break;
      default:
        lang = AppLanguage.english;
    }
    setState(() {
      _currentLanguage = lang;
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '✅ Language changed to:\n$langName',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0B0655),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
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

    int newIndex = first.index;
    if (newIndex > 6) newIndex = 6;

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
            itemCount: 8,
            itemBuilder: (context, index) {
              switch (_currentLanguage) {
                case AppLanguage.english:
                  return _buildEnglishSection(index, isMobile);
                case AppLanguage.sinhala:
                  return _buildSinhalaSection(index, isMobile);
                case AppLanguage.tamil:
                  return _buildTamilSection(index, isMobile);
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
              onLanguageSelected:
                  _onLanguageSelected, // ✅ must be supported in Navbar
            ),
          ),
        ],
      ),
    );
  }

  // English
  Widget _buildEnglishSection(int index, bool isMobile) {
    switch (index) {
      case 0:
        return en_home.HomeSection(
          isMobile: isMobile,
          onInvoiceTap: () {},
          onViewPricingTap: () => scrollTo(2),
        );
      case 1:
        return const en_features.FeaturesSection();
      case 2:
        return const en_pricing.PricingSection();
      case 3:
        return const en_partners.PartnersSection();
      case 4:
        return const en_business.BusinessSection();
      case 5:
        return const en_about.AboutSection();
      case 6:
        return const en_contact.ContactSection();
      case 7:
        return const en_footer.FooterSection();
      default:
        return const SizedBox();
    }
  }

  // Sinhala
  Widget _buildSinhalaSection(int index, bool isMobile) {
    switch (index) {
      case 0:
        return si_home.HomeSection(
          isMobile: isMobile,
          onInvoiceTap: () {},
          onViewPricingTap: () => scrollTo(2),
        );
      case 1:
        return const si_features.FeaturesSection();
      case 2:
        return const si_pricing.PricingSection();
      case 3:
        return const si_partners.PartnersSection();
      case 4:
        return const si_business.BusinessSection();
      case 5:
        return const si_about.AboutSection();
      case 6:
        return const si_contact.ContactSection();
      case 7:
        return const si_footer.FooterSection();
      default:
        return const SizedBox();
    }
  }

  // Tamil
  Widget _buildTamilSection(int index, bool isMobile) {
    switch (index) {
      case 0:
        return ta_home.HomeSection(
          isMobile: isMobile,
          onInvoiceTap: () {},
          onViewPricingTap: () => scrollTo(2),
        );
      case 1:
        return const ta_features.FeaturesSection();
      case 2:
        return const ta_pricing.PricingSection();
      case 3:
        return const ta_partners.PartnersSection();
      case 4:
        return const ta_business.BusinessSection();
      case 5:
        return const ta_about.AboutSection();
      case 6:
        return const ta_contact.ContactSection();
      case 7:
        return const ta_footer.FooterSection();
      default:
        return const SizedBox();
    }
  }
}
