import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0B0655),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: const Center(
        child: Text(
          '© 2025 Bill Till – Smart Billing for a Connected Nation.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
