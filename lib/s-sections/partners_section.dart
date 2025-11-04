import 'package:flutter/material.dart';

class PartnersSection extends StatelessWidget {
  const PartnersSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.orange,
      child: const Center(
        child: Text(
          "Patners",
          style: TextStyle(
            fontSize: 48,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
