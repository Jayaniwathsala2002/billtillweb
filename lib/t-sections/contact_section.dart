// lib/sections/contact_section.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// BillTill Brand Color
const Color _billTillBlue = Color(0xFF0B0655);

class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Header Text
          Text(
            'Ready to Start Building?',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: _billTillBlue,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Let’s discuss your project and discover how we can help you achieve your goals.',
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: const Color(0xFF555555),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),

          // WhatsApp Button (BillTill Blue)
          _WhatsAppButton(),

          const SizedBox(height: 40),

          // Contact Methods (Equal size, no animation)
          _ContactMethods(),

          const SizedBox(height: 60),

          // Contact Form
          const _ContactForm(),
        ],
      ),
    );
  }
}

// 🟦 WhatsApp Button – Now BillTill Blue
class _WhatsAppButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          // Trim whitespace from URL
          final Uri url = Uri.parse('https://wa.me/94701234567');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not open WhatsApp')),
            );
          }
        },
        child: Container(
          width: 220,
          height: 70,
          decoration: BoxDecoration(
            color: _billTillBlue,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.chat_bubble_outline, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Text(
                'Chat with us',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 📞 Contact Methods – Equal size, no animation, MORE SPACE BETWEEN
class _ContactMethods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final methods = [
      _ContactMethod(
        icon: Icons.phone,
        title: 'Call Us',
        detail: '+94 11 475 8900',
        url: Uri.parse('tel:+94114758900'),
      ),
      _ContactMethod(
        icon: Icons.email,
        title: 'Email Us',
        detail: 'support@billtill.co',
        url: Uri.parse('mailto:support@billtill.co'),
      ),
      _ContactMethod(
        icon: Icons.location_on,
        title: 'Visit Us',
        detail: 'Negombo, Sri Lanka',
        url: Uri.parse(
            'https://www.google.com/maps/place/Ceylon+Innovation+Services+(PVT)+LTD/@7.2344801,79.8481646,17z/data=!4m6!3m5!1s0x3ae2cb6c28738405:0x9929b748309020af!8m2!3d7.2340544!4d79.8494628!16s%2Fg%2F11jg88xt2s?entry=ttu&g_ep=EgoyMDI5MTAyMi4wIKXMDSoASAFQAw%3D%3D'),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          // ✅ Desktop: Increase spacing BETWEEN boxes
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              methods[0],
              const SizedBox(width: 32), // ← More space
              methods[1],
              const SizedBox(width: 32), // ← More space
              methods[2],
            ],
          );
        } else {
          // ✅ Mobile: Increase vertical padding BETWEEN boxes
          return Column(
            children: [
              methods[0],
              const SizedBox(height: 24), // ← More space
              methods[1],
              const SizedBox(height: 24), // ← More space
              methods[2],
            ],
          );
        }
      },
    );
  }
}

class _ContactMethod extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  final Uri url;

  const _ContactMethod({
    required this.icon,
    required this.title,
    required this.detail,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not open: $detail')),
            );
          }
        },
        child: Container(
          // ✅ Fixed width for equal size
          width: 200,
          height: 160,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: _billTillBlue),
              const SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _billTillBlue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                detail,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFF555555),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 📝 Contact Form
class _ContactForm extends StatefulWidget {
  const _ContactForm({Key? key}) : super(key: key);

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send us a message',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: _billTillBlue,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
                labelStyle: GoogleFonts.poppins(
                    fontSize: 14, color: Colors.grey.shade600),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _billTillBlue),
                ),
              ),
              validator: (value) =>
                  value?.isEmpty == true ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Your Email',
                labelStyle: GoogleFonts.poppins(
                    fontSize: 14, color: Colors.grey.shade600),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _billTillBlue),
                ),
              ),
              validator: (value) {
                if (value?.isEmpty == true) return 'Please enter your email';
                if (value != null &&
                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Your Message',
                labelStyle: GoogleFonts.poppins(
                    fontSize: 14, color: Colors.grey.shade600),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _billTillBlue),
                ),
              ),
              validator: (value) =>
                  value?.isEmpty == true ? 'Please enter your message' : null,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Message sent! We’ll reply soon.')),
                    );
                    _formKey.currentState!.reset();
                    _nameController.clear();
                    _emailController.clear();
                    _messageController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _billTillBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Text(
                  'Send Message',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
