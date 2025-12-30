// lib/screens/parents/raise_ticket_page.dart
import 'package:flutter/material.dart';
import '../../routes/parents_routes.dart';

final Color _headerOrange = const Color(0xFFFF5722); // Vibrant Deep Orange
final Color _accentOrange = const Color(0xFFFF5722);

class RaiseTicketPage extends StatefulWidget {
  const RaiseTicketPage({Key? key}) : super(key: key);

  @override
  _RaiseTicketPageState createState() => _RaiseTicketPageState();
}

class _RaiseTicketPageState extends State<RaiseTicketPage> {
  String _selectedLanguage = 'తెలుగు';

  // Colors
  final Color _primaryBlue = const Color(0xFF2563EB);
  final Color _scaffoldBg = Colors.white;
  final Color _textPrimary = const Color(0xFF1F2937);
  final Color _textSecondary = const Color(0xFF6B7280);
  final Color _borderColor = const Color(0xFFE5E7EB);

  // Form controllers
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు';
    });
  }

  void _submitTicket() {
    if (_categoryController.text.isEmpty ||
        _subjectController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ticket raised successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate back to tickets page
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, ParentsRoutes.tickets);
    });
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F9FB), // Subtle off-white for premium feel
      body: SafeArea(
        child: Column(
          children: [
            /// 1. App Header (Consistent Branding)
            _buildAppHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 2. Navigation & Title
                    _buildNavigationRow(context),

                    const SizedBox(height: 24),

                    /// 3. Form Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionLabel("Category", isRequired: true),
                          _buildDropdownField("Select category"),

                          const SizedBox(height: 20),

                          _buildSectionLabel("Subject", isRequired: true),
                          _buildModernTextField(
                            controller: _subjectController,
                            hint: "Short title of your issue",
                          ),

                          const SizedBox(height: 20),

                          _buildSectionLabel("Description", isRequired: true),
                          _buildModernTextField(
                            controller: _descriptionController,
                            hint: "Explain your concern in detail...",
                            maxLines: 4,
                          ),

                          const SizedBox(height: 24),

                          /// 4. Enhanced Voice Note Section
                          _buildSectionLabel("Voice Note", isRequired: false),
                          _buildVoiceRecorderUI(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    /// 5. Premium Action Button
                    _buildSubmitButton(),

                    const SizedBox(height: 20),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.info_outline,
                              size: 14, color: Colors.grey.shade400),
                          const SizedBox(width: 6),
                          Text(
                            "Typical response time: < 24 hours",
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// --- UI Helper Components ---

  Widget _buildAppHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFFFF5722), Color(0xFFFF8A65)]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.school, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Aditya International",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      letterSpacing: -0.5)),
              Text("Support Portal",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
            ],
          ),
          const Spacer(),
          _buildLanguageToggle(),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Row(
        children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF2D2D2D))),
          if (isRequired)
            Text(" *",
                style: TextStyle(
                    color: Colors.red.shade400, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildModernTextField(
      {required TextEditingController controller,
      required String hint,
      int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildVoiceRecorderUI() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD1DBFF)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.mic_rounded,
                color: Color(0xFF6C63FF), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Tap to record audio",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                Text("Max 2:00 mins",
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 11)),
              ],
            ),
          ),
          Icon(Icons.play_circle_outline_rounded, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF6C63FF).withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8)),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF), // Modern Purple/Blue
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text("Submit Ticket",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildNavigationRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Back Button with Soft Shadow
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Screen Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Raise New Ticket",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.7,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Tell us what's on your mind",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String hint) {
    return InkWell(
      onTap: () {
        // Yahan aap apna BottomSheet ya Dropdown menu open kar sakte hain
        _showCategoryPicker(context);
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            Icon(Icons.category_outlined,
                size: 20, color: Colors.grey.shade600),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _categoryController.text.isEmpty
                    ? hint
                    : _categoryController.text,
                style: TextStyle(
                  fontSize: 14,
                  color: _categoryController.text.isEmpty
                      ? Colors.grey.shade400
                      : const Color(0xFF1A1A1A),
                  fontWeight: _categoryController.text.isEmpty
                      ? FontWeight.normal
                      : FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

// Category select karne ke liye ek clean Modal Sheet
  void _showCategoryPicker(BuildContext context) {
    final List<String> categories = [
      'Fees Issue',
      'Bus Route',
      'Academic',
      'Technical Support',
      'Others'
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Select Category",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            ...categories.map((cat) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  title: Text(cat,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  trailing: _categoryController.text == cat
                      ? const Icon(Icons.check_circle, color: Color(0xFF6C63FF))
                      : null,
                  onTap: () {
                    setState(() => _categoryController.text = cat);
                    Navigator.pop(context);
                  },
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageToggle() {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey.shade200, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Globe Icon
            Icon(
              Icons.translate_rounded,
              size: 16,
              color: _headerOrange, // Your theme orange color
            ),
            const SizedBox(width: 8),

            // Language Text
            Text(
              _selectedLanguage,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                letterSpacing: 0.2,
              ),
            ),

            const SizedBox(width: 4),

            // Small Down Arrow
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 14,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: 14,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixIcon: icon != null
            ? Icon(
                icon,
                color: Colors.grey[500],
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _primaryBlue),
        ),
      ),
    );
  }
}
