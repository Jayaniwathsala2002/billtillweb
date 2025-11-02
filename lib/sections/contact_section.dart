import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 🔹 needed for LogicalKeyboardKey
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Focus nodes for keyboard navigation
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _subjectFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _messageFocus = FocusNode();

  bool _isContactSectionVisible = false;
  int _messageEnterCount = 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    // Set up focus node listeners for keyboard navigation
    _setupFocusListeners();

    // Simulate intersection observer - start animation when widget builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
      setState(() {
        _isContactSectionVisible = true;
      });
    });
  }

  void _setupFocusListeners() {
    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) {
        _messageEnterCount = 0; // Reset enter count when leaving message field
      }
    });

    _messageFocus.addListener(() {
      if (_messageFocus.hasFocus) {
        _messageEnterCount = 0; // Reset when focusing on message field
      }
    });
  }

  void _handleKeyEvent(
      RawKeyEvent event, FocusNode currentFocus, FocusNode nextFocus) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.enter) {
      if (currentFocus == _messageFocus) {
        _messageEnterCount++;
        if (_messageEnterCount >= 2) {
          // Double enter in message field - submit form
          _submitForm();
          _messageEnterCount = 0;
        }
      } else {
        // Single enter in other fields - move to next field
        nextFocus.requestFocus();
      }
    }
  }

  void _callHotline() async {
    const String phoneNumber = 'tel:0114758900';
    final Uri uri = Uri.parse(phoneNumber);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  void _sendEmail() async {
    const String email = 'mailto:support@billtill.co';
    final Uri uri = Uri.parse(email);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  void _openWhatsApp() async {
    const String whatsapp = 'https://wa.me/94701234567';
    final Uri uri = Uri.parse(whatsapp);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  void _openAddress() async {
    const String mapsUrl =
        'https://www.google.com/maps/place/Ceylon+Innovation+Services+(PVT)+LTD/@7.2344801,79.8481646,17z/data=!4m6!3m5!1s0x3ae2cb6c28738405:0x9929b748309020af!8m2!3d7.2340544!4d79.8494628!16s%2Fg%2F11jg88xt2s?entry=ttu&g_ep=EgoyMDI5MTAyMi4wIKXMDSoASAFQAw%3D%3D';
    final Uri uri = Uri.parse(mapsUrl);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      const text =
          'Hi Bill Till,%0A%0AI am interested in your POS system. Please provide me with more details.%0A%0AThank you!';
      final url = 'https://wa.me/94770600508?text=$text';

      _launchURL(url);

      // Reset form
      _formKey.currentState!.reset();
      // Reset focus to first field
      _nameFocus.requestFocus();
      _messageEnterCount = 0;
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static const Color mainTextColor = Color(0xFF0B0655);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      color: Colors.lightBlue.shade50, // Light blue background
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Contact Us',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: mainTextColor.withOpacity(0.827), // Original text color
            ),
          ),
          const SizedBox(height: 40),

          // Contact Methods - Made more compact
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              ContactMethod(
                icon: Icons.phone,
                title: 'Hotline',
                detail: '0114 758 900',
                onTap: _callHotline,
              ),
              ContactMethod(
                icon: Icons.email,
                title: 'Email',
                detail: 'support@billtill.co',
                onTap: _sendEmail,
              ),
              ContactMethod(
                icon: Icons.location_on,
                title: 'Address',
                detail: '680A Colombo Road, Kattuwa, Negombo',
                onTap: _openAddress,
              ),
              ContactMethod(
                icon: Icons.chat,
                title: 'WhatsApp',
                detail: 'Chat with us',
                onTap: _openWhatsApp,
              ),
            ],
          ),
          const SizedBox(height: 40),

          // NEW CONTACT FORM SECTION - Made responsive
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                // Desktop layout
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildContactBox(),
                  ),
                );
              } else {
                // Mobile layout - stacked vertically
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildMobileContactBox(),
                  ),
                );
              }
            },
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildContactBox() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 1100),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side
          Expanded(
            flex: 1,
            child: _buildLeftSide(),
          ),

          // Right side
          Expanded(
            flex: 2,
            child: _buildRightSide(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileContactBox() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [
          // Left side
          _buildLeftSide(),

          // Right side
          _buildRightSide(),
        ],
      ),
    );
  }

  Widget _buildLeftSide() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFf0f4ff),
            Colors.white,
          ],
        ),
        border: Border(
          right: BorderSide(color: Color(0xFFeeeeee)),
          bottom: BorderSide(color: Color(0xFFeeeeee)), // For mobile
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                fontSize: 24, // Slightly smaller for better fit
                fontWeight: FontWeight.w700,
                color: Color(0xFF1a0a85),
                height: 1.3,
              ),
              children: [
                TextSpan(text: "Let's Build Something\nGreat "),
                TextSpan(
                  text: "Together",
                  style: TextStyle(color: Color(0x8032a3e4)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            "We're always here to help you grow your business with Bill Till. Whether you have a question or need support, we'd love to hear from you.",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Color(0xFF555555),
              height: 1.6,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Fast response time, dedicated support, and seamless integration.",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Color(0xFF555555),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightSide() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      color: Colors.white,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(), // Prevent nested scrolling
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title with underline
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  "Get In Touch",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1a0a85),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  child: Container(
                    width: 60,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Color(0x8032a3e4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Form
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Name and Email row
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 500) {
                        return Row(
                          children: [
                            Expanded(
                              child: RawKeyboardListener(
                                focusNode: FocusNode(),
                                onKey: (event) => _handleKeyEvent(
                                    event, _nameFocus, _emailFocus),
                                child: _buildTextField(
                                  controller: _nameController,
                                  label: "Your Name",
                                  isRequired: true,
                                  focusNode: _nameFocus,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: RawKeyboardListener(
                                focusNode: FocusNode(),
                                onKey: (event) => _handleKeyEvent(
                                    event, _emailFocus, _subjectFocus),
                                child: _buildTextField(
                                  controller: _emailController,
                                  label: "Your Email",
                                  isRequired: true,
                                  keyboardType: TextInputType.emailAddress,
                                  focusNode: _emailFocus,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            RawKeyboardListener(
                              focusNode: FocusNode(),
                              onKey: (event) => _handleKeyEvent(
                                  event, _nameFocus, _emailFocus),
                              child: _buildTextField(
                                controller: _nameController,
                                label: "Your Name",
                                isRequired: true,
                                focusNode: _nameFocus,
                              ),
                            ),
                            SizedBox(height: 16),
                            RawKeyboardListener(
                              focusNode: FocusNode(),
                              onKey: (event) => _handleKeyEvent(
                                  event, _emailFocus, _subjectFocus),
                              child: _buildTextField(
                                controller: _emailController,
                                label: "Your Email",
                                isRequired: true,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: _emailFocus,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),

                  // Subject and Phone row
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 500) {
                        return Row(
                          children: [
                            Expanded(
                              child: RawKeyboardListener(
                                focusNode: FocusNode(),
                                onKey: (event) => _handleKeyEvent(
                                    event, _subjectFocus, _phoneFocus),
                                child: _buildTextField(
                                  controller: _subjectController,
                                  label: "Subject",
                                  isRequired: true,
                                  focusNode: _subjectFocus,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: RawKeyboardListener(
                                focusNode: FocusNode(),
                                onKey: (event) => _handleKeyEvent(
                                    event, _phoneFocus, _messageFocus),
                                child: _buildTextField(
                                  controller: _phoneController,
                                  label: "Phone Number",
                                  keyboardType: TextInputType.phone,
                                  focusNode: _phoneFocus,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            RawKeyboardListener(
                              focusNode: FocusNode(),
                              onKey: (event) => _handleKeyEvent(
                                  event, _subjectFocus, _phoneFocus),
                              child: _buildTextField(
                                controller: _subjectController,
                                label: "Subject",
                                isRequired: true,
                                focusNode: _subjectFocus,
                              ),
                            ),
                            SizedBox(height: 16),
                            RawKeyboardListener(
                              focusNode: FocusNode(),
                              onKey: (event) => _handleKeyEvent(
                                  event, _phoneFocus, _messageFocus),
                              child: _buildTextField(
                                controller: _phoneController,
                                label: "Phone Number",
                                keyboardType: TextInputType.phone,
                                focusNode: _phoneFocus,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),

                  // Message
                  RawKeyboardListener(
                    focusNode: FocusNode(),
                    onKey: (event) =>
                        _handleKeyEvent(event, _messageFocus, _messageFocus),
                    child: _buildTextField(
                      controller: _messageController,
                      label: "Your Message...",
                      isRequired: true,
                      maxLines: 4,
                      isTextArea: true,
                      focusNode: _messageFocus,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Submit button
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0B0655),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 6,
                        shadowColor: Color(0xFF0B0655).withOpacity(0.679),
                      ),
                      child: Text(
                        "Send Message",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool isRequired = false,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isTextArea = false,
    FocusNode? focusNode,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isTextArea ? TextInputType.multiline : keyboardType,
      maxLines: maxLines,
      focusNode: focusNode,
      textInputAction:
          isTextArea ? TextInputAction.newline : TextInputAction.next,
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'This field is required';
        }
        if (keyboardType == TextInputType.emailAddress && value!.isNotEmpty) {
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Please enter a valid email';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Color(0xFFaaaaaa),
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: true,
        fillColor: Color(0xFFfafafa),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFe0e0e0), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFe0e0e0), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0x8032a3e4), width: 2),
        ),
        contentPadding: EdgeInsets.fromLTRB(
            16, isTextArea ? 16 : 12, 16, isTextArea ? 16 : 12),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _subjectFocus.dispose();
    _phoneFocus.dispose();
    _messageFocus.dispose();
    super.dispose();
  }
}

// ---------------- CONTACT METHOD CARD ----------------

class ContactMethod extends StatefulWidget {
  final IconData icon;
  final String title;
  final String detail;
  final VoidCallback onTap;

  const ContactMethod({
    super.key,
    required this.icon,
    required this.title,
    required this.detail,
    required this.onTap,
  });

  static const Color mainTextColor = Color(0xFF0B0655);

  @override
  State<ContactMethod> createState() => _ContactMethodState();
}

class _ContactMethodState extends State<ContactMethod> {
  bool _isHovered = false;

  void _onEnter(bool hover) {
    setState(() {
      _isHovered = hover;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onEnter(true),
      onExit: (_) => _onEnter(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: 200, // Slightly smaller for better fit
          height: 160, // Slightly smaller for better fit
          padding: const EdgeInsets.all(20),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0, -5, 0))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? Colors.black.withOpacity(0.25)
                    : Colors.black.withOpacity(0.1),
                blurRadius: _isHovered ? 16 : 8,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 35, // Slightly smaller
                color: Colors.blue.shade600,
              ),
              const SizedBox(height: 10),
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ContactMethod.mainTextColor.withOpacity(0.827),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.detail,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12, // Slightly smaller
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
