import 'package:flutter/material.dart';

class BusinessSection extends StatelessWidget {
  const BusinessSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.teal,
      child: const Center(
        child: Text(
          "Business",
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
