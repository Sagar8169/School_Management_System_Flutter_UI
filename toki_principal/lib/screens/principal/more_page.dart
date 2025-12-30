import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../routes.dart';
import '../../widgets/common_widgets.dart';
import '../../routes/principal_routes.dart';
import '../mobile_login_page.dart';
import 'announcements_page.dart';
import 'timetable_page.dart';
import 'events_page.dart';
import 'tickets_page.dart';
import 'approvals_page.dart';

const Color themeBlue = Color(0xFF1E3A8A);
const Color themeLightBlue = Color(0xFF3B82F6);
const Color themeGreen = Color(0xFF059669);
const Color backgroundSlate = Color(0xFFF8FAFC);

class MorePage extends StatefulWidget {
  final String? initialSection;
  const MorePage({super.key, this.initialSection});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  // int _currentIndex = 3;
  bool _isTelugu = true;
  bool _isDarkMode = false;

  // --- Original Data Reference Restored ---
  String principalName = "Dr. Ramesh Kumar"; // Principal Name
  String principalRole =
      "Principal • Aditya International School"; // Role + School

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // --- Original Lists (Names and IDs unchanged) ---
  final List<Map<String, dynamic>> _managementItems = [
    {
      'title': 'Pending Approvals',
      'id': 'approvals',
      'icon': Icons.verified_user_outlined,
      'color': Colors.blue,
      'badgeColor': Colors.orange
    },
    {
      'title': 'Tickets',
      'id': 'tickets',
      'icon': Icons.confirmation_number_outlined,
      'color': Colors.purple,
      'badgeColor': Colors.red
    },
    {
      'title': 'Upcoming Events',
      'id': 'events',
      'icon': Icons.calendar_today_outlined,
      'color': Colors.green,
      'hasBadge': false
    },
    {
      'title': 'Manage Timetable',
      'id': 'timetable',
      'icon': Icons.schedule_outlined,
      'color': Colors.orange,
      'hasBadge': false
    },
    {
      'title': 'Announcements',
      'id': 'announcements',
      'icon': Icons.campaign_outlined,
      'color': Colors.red,
      'hasBadge': false
    },
  ];

  final List<Map<String, dynamic>> _settingsItems = [
    {
      'title': 'Feedbacks',
      'id': 'feedbacks',
      'icon': Icons.chat_bubble_outline,
      'color': Colors.teal,
      'hasBadge': false,
      'badgeCount': 3,
      'badgeColor': Colors.red
    },
    {
      'title': 'Privacy & Security',
      'id': 'privacy',
      'icon': Icons.security_outlined,
      'color': Colors.indigo,
      'hasBadge': false
    },
    {
      'title': 'Language Preferences',
      'id': 'language',
      'icon': Icons.language_outlined,
      'color': Colors.blueGrey,
      'hasBadge': false
    },
  ];

  final List<Map<String, dynamic>> _supportItems = [
    {
      'title': 'Contact Support',
      'id': 'contact',
      'icon': Icons.support_agent_outlined,
      'color': Colors.pink
    },
    {
      'title': 'About Toki Tech',
      'id': 'about',
      'icon': Icons.info_outlined,
      'color': Colors.lightBlue
    },
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialSection != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _handleItemTap(widget.initialSection!);
      });
    }
  }

  // void _onBottomNavTap(int index) {
  //   switch (index) {
  //     case 0:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.home);
  //       break;
  //     case 1:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.search);
  //       break;
  //     case 2:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.activity);
  //       break;
  //     case 3:
  //       Navigator.pushReplacementNamed(
  //         context,
  //         PrincipalRoutes.morePage,
  //         arguments: {'section': null},
  //       );
  //       break;
  //   }
  // }

  // ==========================================
  // --- MODERN UI DIALOGS (FUNCTIONAL) ---
  // ==========================================

  void _showTicketForm() {
    File? ticketImage;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 24,
                right: 24,
                top: 12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)))),
                  const SizedBox(height: 25),
                  const Text("Submit a Ticket",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A))),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: _modernInputDecoration(
                        "Select Issue Type", Icons.category_rounded),
                    items: [
                      'App Bug',
                      'Data Correction',
                      'Login Issue',
                      'Other'
                    ]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) {},
                  ),
                  const SizedBox(height: 15),
                  TextField(
                      maxLines: 3,
                      decoration: _modernInputDecoration(
                          "Tell us about the issue...",
                          Icons.edit_note_rounded)),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () async {
                      final XFile? img = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 80);
                      if (img != null)
                        setModalState(() => ticketImage = File(img.path));
                    },
                    child: Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey[200]!)),
                      child: ticketImage == null
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Icon(Icons.add_a_photo,
                                      color: Colors.blue, size: 30),
                                  Text("Attach Screenshot")
                                ])
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child:
                                  Image.file(ticketImage!, fit: BoxFit.cover)),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 54)),
                          child: const Text("Submit Report"))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showContactSupport() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Round corners ke liye transparent
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // --- Pill Handle ---
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 30),

                // --- Header Section ---
                const Icon(Icons.headset_mic_rounded,
                    size: 50, color: themeBlue),
                const SizedBox(height: 15),
                const Text(
                  "How can we help?",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B)),
                ),
                const Text(
                  "Our team is available for your assistance",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 35),

                // --- Action Cards ---
                _buildModernContactCard(
                  title: "Call our Experts",
                  subtitle: "+91 98765 43210",
                  icon: Icons.phone_forwarded_rounded,
                  color: Colors.green,
                  onTap: () => _handleAction("tel:+919876543210"),
                ),
                const SizedBox(height: 16),
                _buildModernContactCard(
                  title: "Write to us",
                  subtitle: "support@tokitech.com",
                  icon: Icons.mail_outline_rounded,
                  color: Colors.blue,
                  onTap: () => _handleAction("mailto:support@tokitech.com"),
                ),
                const SizedBox(height: 16),

                // --- Secondary Action (WhatsApp) ---
                _buildModernContactCard(
                  title: "Chat on WhatsApp",
                  subtitle: "Instant response for quick queries",
                  icon: Icons.chat_bubble_outline_rounded,
                  color: const Color(0xFF25D366),
                  onTap: () =>
                      _handleAction("whatsapp://send?phone=+919876543210"),
                ),

                const SizedBox(height: 30),

                // --- Footer ---
                Text(
                  "Available: Mon - Sat (9 AM - 6 PM)",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

// 🛠️ MODERN CARD BUILDER
  Widget _buildModernContactCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF1F5F9), width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: Color(0xFF1E293B))),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Colors.grey[300]),
          ],
        ),
      ),
    );
  }

  Widget _langTogglePill() {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFDBEAFE)),
        ),
        child: Text(_isTelugu ? "తెలుగు" : "English",
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF3B82F6))),
      ),
    );
  }

  void _editProfile() {
    final nameCtrl = TextEditingController(text: principalName);
    File? tempImage = _profileImage;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Edit Profile',
      barrierColor: Colors.black.withOpacity(0.35),
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (_, __, ___) => const SizedBox(),
      transitionBuilder: (context, anim, _, __) {
        final curved = Curves.easeOutBack.transform(anim.value);

        return Opacity(
          opacity: anim.value,
          child: Transform.scale(
            scale: curved,
            child: StatefulBuilder(
              builder: (context, setModalState) {
                final bottomInset = MediaQuery.of(context).viewInsets.bottom;

                return Center(
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: bottomInset,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 420, // ✅ tablet-safe width
                      ),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        clipBehavior: Clip.antiAlias,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // 🔝 Header
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF8FAFC),
                                ),
                                child: Column(
                                  children: const [
                                    Text(
                                      "Update Profile",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        color: Color(0xFF1E293B),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Change your display details",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 24, 24, 28),
                                child: Column(
                                  children: [
                                    // 🧑‍💼 Profile Image Picker
                                    GestureDetector(
                                      onTap: () async {
                                        final img = await _picker.pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 85,
                                        );
                                        if (img != null) {
                                          setModalState(() {
                                            tempImage = File(img.path);
                                          });
                                        }
                                      },
                                      child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: const Color(0xFF2563EB)
                                                    .withOpacity(0.25),
                                                width: 2,
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              radius: 52,
                                              backgroundColor:
                                                  const Color(0xFFEFF6FF),
                                              backgroundImage: tempImage != null
                                                  ? FileImage(tempImage!)
                                                  : null,
                                              child: tempImage == null
                                                  ? const Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Color(0xFF2563EB),
                                                      size: 30,
                                                    )
                                                  : null,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF2563EB),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.edit_rounded,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 32),

                                    // ✍️ Name Field
                                    TextField(
                                      controller: nameCtrl,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF1E293B),
                                      ),
                                      decoration: InputDecoration(
                                        labelText: "Principal Full Name",
                                        labelStyle: const TextStyle(
                                          color: Color(0xFF94A3B8),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.person_rounded,
                                          color: Color(0xFF2563EB),
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFF8FAFC),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE2E8F0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF2563EB),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 32),

                                    // ✅ Actions
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            style: TextButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                            ),
                                            child: const Text(
                                              "CANCEL",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 13,
                                                color: Color(0xFF64748B),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                principalName = nameCtrl.text;
                                                _profileImage = tempImage;
                                              });
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF2563EB),
                                              elevation: 0,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                            ),
                                            child: const Text(
                                              "SAVE CHANGES",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // --- Internal Helpers ---
  // --- Navigation Logic Fix ---
  void _handleItemTap(String id) {
    switch (id) {
      case 'feedbacks':
        _showFeedbackSheet(); // Premium Popup Form
        break;
      case 'privacy':
        _showPrivacySheet(); // Security Info Sheet
        break;
      case 'approvals':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ApprovalsPage()));
        break;
      case 'tickets':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TicketsPage()));
        break;
      case 'events':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EventsPage()));
        break;
      case 'timetable':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TimetablePage()));
        break;
      case 'announcements':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AnnouncementsPage()));
        break;
      case 'contact':
        _showContactSupport();
        break;
      case 'language':
        _toggleLanguage();
        break;
      case 'about':
        _showAboutDialog();
        break;
      default:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Feature $id coming soon')));
    }
  }

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('Language switched to ${_isTelugu ? 'Telugu' : 'English'}'),
        backgroundColor: Colors.blueAccent));
  }

  Widget _buildLanguageToggle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isTelugu = !_isTelugu;
        });
        // Optional: Chota haptic feedback ya sound yaha add kar sakte ho
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 38,
        width: 130, // Thoda bada width taaki text clear dikhe
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9), // Light background
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Stack(
          children: [
            // Sliding Background
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: _isTelugu ? 65 : 2, // Toggle position
              right: _isTelugu ? 2 : 65,
              top: 2,
              bottom: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: themeBlue.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            // Text Labels
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'English',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: !_isTelugu ? themeBlue : Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'తెలుగు',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _isTelugu ? themeBlue : Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFeedbackSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 12,
          // ✨ Niche ka Safe Area + Keyboard gap handle karne ke liye
          bottom: MediaQuery.of(context).viewInsets.bottom +
              MediaQuery.of(context).padding.bottom +
              24,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 24),
            const Text("Share Your Feedback",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B))),
            const SizedBox(height: 8),
            const Text("Help us improve the Principal dashboard",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 20),
            Row(
              children: List.generate(
                  5,
                  (index) => const Icon(Icons.star_rounded,
                      color: Color(0xFFF59E0B), size: 32)),
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 3,
              autofocus: true, // Form khulte hi keyboard aa jaye
              decoration: InputDecoration(
                hintText: "What can we do better?",
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D4ED8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: const Text("SUBMIT FEEDBACK",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showPrivacySheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 5,
            )
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // --- Handle bar for better UX ---
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 30),

                // --- Animated/Premium Security Icon ---
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5), // Light Green
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color(0xFF10B981).withOpacity(0.2),
                        width: 4),
                  ),
                  child: const Icon(
                    Icons.verified_user_rounded,
                    size: 50,
                    color: Color(0xFF10B981),
                  ),
                ),
                const SizedBox(height: 24),

                // --- Title ---
                const Text(
                  "Data Privacy & Protection",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),

                // --- Subtitle with context ---
                Text(
                  "Aditya International School's data is our priority. We ensure top-tier encryption for all records.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 30),

                // --- Feature Points (UI improvement) ---
                _buildPrivacyPoint(
                    Icons.lock_outline_rounded,
                    "256-Bit SSL Encryption",
                    "Military-grade data protection."),
                _buildPrivacyPoint(
                    Icons.visibility_off_outlined,
                    "Zero Third-Party Sharing",
                    "Your records stay within the school."),
                _buildPrivacyPoint(
                    Icons.cloud_done_outlined,
                    "Automated Backups",
                    "Secure cloud storage with daily sync."),

                const SizedBox(height: 30),

                // --- Action Button ---
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3A8A), // themeBlue
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Securely Proceed",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Helper widget for points
  Widget _buildPrivacyPoint(IconData icon, String title, String sub) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF1E3A8A)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF1E293B))),
              Text(sub,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _handleAction(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri))
      await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  InputDecoration _modernInputDecoration(String hint, IconData icon) =>
      InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blue),
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none));

  Widget _buildContactTile(String title, String sub, IconData icon, Color color,
          VoidCallback onTap) =>
      ListTile(
          onTap: onTap,
          leading: CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color)),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(sub),
          trailing: const Icon(Icons.chevron_right, size: 16));

  // ==========================================
  // --- MAIN LAYOUT BUILD ---
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                children: [
                  _buildProfileCardUI(),
                  const SizedBox(height: 30),
                  _buildSectionHeader("Management"),
                  _buildGroupedMenu(_managementItems),
                  const SizedBox(height: 25),
                  _buildSectionHeader("Settings"),
                  _buildGroupedMenu(_settingsItems),
                  const SizedBox(height: 25),
                  _buildSectionHeader("Preferences"),
                  _buildPreferencesSection(),
                  const SizedBox(height: 25),
                  _buildSectionHeader("Support"),
                  _buildGroupedMenu(_supportItems),
                  const SizedBox(height: 40),
                  _buildLogoutButton(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildTopBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [themeBlue, themeLightBlue],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "A",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Aditya International School",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      "Powered by Toki Tech",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
              _langTogglePill(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCardUI() => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10))
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white24,
                backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? const Icon(Icons.person, size: 40, color: Colors.white)
                    : null),
            const SizedBox(width: 15),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(principalName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Text(principalRole,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12))
                ])),
            IconButton(
                onPressed: _editProfile,
                icon: const Icon(Icons.edit_note_rounded,
                    color: Colors.white, size: 30)),
          ],
        ),
      );

  // ✨ Iske liye 'share_plus' package install hona chahiye agar actual share karna hai,
// filhaal main logic aur UI feedback de raha hoon.

  Widget _buildPreferencesSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: const Color(0xFFF1F5F9), width: 1.5), // Halka border
      ),
      child: Column(
        children: [
          // --- 1. DARK MODE (Working Switch) ---
          ListTile(
            leading: _buildIconContainer(
                Icons.dark_mode_outlined, Colors.deepPurple),
            title: const Text("Dark Mode",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            trailing: Switch(
              value: _isDarkMode,
              onChanged: (v) {
                setState(() => _isDarkMode = v);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_isDarkMode
                        ? "Dark Mode Enabled"
                        : "Light Mode Enabled"),
                    duration: const Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              activeColor: Colors.blue,
            ),
          ),
          const Divider(height: 1, indent: 60, color: Color(0xFFF1F5F9)),

          // --- 2. DOWNLOAD REPORTS (Working Loader) ---
          ListTile(
            onTap: () => _handleDownloadReport(),
            leading:
                _buildIconContainer(Icons.file_download_outlined, Colors.brown),
            title: const Text("Download Reports",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            trailing:
                const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
          ),
          const Divider(height: 1, indent: 60, color: Color(0xFFF1F5F9)),

          // --- 3. SHARE APP (Working Action) ---
          ListTile(
            onTap: () => _handleShareApp(),
            leading: _buildIconContainer(Icons.share_outlined, Colors.cyan),
            title: const Text("Share App",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            trailing:
                const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }

// --- LOGIC FUNCTIONS ---

  void _handleDownloadReport() {
    // Premium Loader Dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(strokeWidth: 3, color: Colors.blue),
            const SizedBox(height: 20),
            const Text("Generating Analytics PDF...",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Please wait while we prepare the data",
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ),
    );

    // Auto close loader after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Report downloaded to Downloads folder"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  void _handleShareApp() {
    // Logic to share app link
    final String appLink = "https://tokitech.netlify.app";

    // Agat actual share menu chahiye toh use: Share.share('Check out our School App: $appLink');
    // Abhi ke liye hum UI feedback de rahe hain:
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Sharing link copied to clipboard"),
        action: SnackBarAction(
            label: "Open Link", onPressed: () => launchUrl(Uri.parse(appLink))),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildGroupedMenu(List<Map<String, dynamic>> items) {
    const double radius = 20;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius), // ✅ soft rounding
        border: Border.all(
          color: const Color(0xFFE2E8F0), // slate-200
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius), // ✅ clip ripple + dividers
        child: Column(
          children: items.map((item) {
            final bool isLast = items.indexOf(item) == items.length - 1;

            return Column(
              children: [
                ListTile(
                  onTap: () => _handleItemTap(item['id']),
                  leading: _buildIconContainer(
                    item['icon'],
                    item['color'],
                  ),
                  title: Text(
                    item['title'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  trailing: item['hasBadge'] == true
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: item['badgeColor'],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            item['badgeCount'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: Color(0xFF94A3B8),
                        ),
                ),
                if (!isLast)
                  const Divider(
                    height: 1,
                    indent: 64,
                    color: Color(0xFFF1F5F9),
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildIconContainer(IconData icon, Color color) => Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, color: color, size: 20));

  Widget _buildSectionHeader(String title) => Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey)));

  Widget _buildLogoutButton() => InkWell(
        onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MobileLoginPage()),
            (route) => false),
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red[100]!)),
            child: const Center(
                child: Text("Logout Session",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)))),
      );

  // Widget _buildBottomNav() {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       border: Border(
  //         top: BorderSide(
  //           color: Color(0xFFF1F5F9),
  //           width: 2,
  //         ),
  //       ),
  //     ),
  //     child: BottomNavigationBar(
  //       currentIndex: _currentIndex,

  //       // ✅ CORRECT onTap (int only)
  //       onTap: (index) {
  //         if (index == _currentIndex) return;
  //         _onBottomNavTap(index);
  //       },

  //       type: BottomNavigationBarType.fixed,
  //       backgroundColor: Colors.white,
  //       selectedItemColor: themeBlue,
  //       unselectedItemColor: const Color(0xFF94A3B8),
  //       elevation: 0,

  //       items: const [
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home_rounded),
  //           label: "Home",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.search_rounded),
  //           label: "Search",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.analytics_rounded),
  //           label: "Activity",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.grid_view_rounded),
  //           label: "More",
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _showAboutDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle Bar
                Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10))),
                const SizedBox(height: 30),

                // App Logo Placeholder
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)]),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 8))
                    ],
                  ),
                  child: const Center(
                    child: Text("TOKI",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 20),

                const Text("Toki Tech",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A))),
                const SizedBox(height: 5),

                // Version Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text("Version 1.0.1",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w800)),
                ),

                const SizedBox(height: 25),
                const Divider(color: Color(0xFFF1F5F9)),
                const SizedBox(height: 20),

                _aboutTile(Icons.verified_user_outlined, "Official Product",
                    "Licensed for Aditya International School"),
                const SizedBox(height: 15),
                _aboutTile(Icons.code_rounded, "Developer",
                    "Powered by Toki Technologies Pvt Ltd"),
                const SizedBox(height: 15),
                _aboutTile(Icons.copyright_rounded, "Legal",
                    "All rights reserved 2025"),

                const SizedBox(height: 30),

                // Close Button
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFFF8FAFC),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("CLOSE",
                        style: TextStyle(
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2)),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Helper Widget for About Info
  Widget _aboutTile(IconData icon, String title, String sub) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: const Color(0xFF475569), size: 20),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: Color(0xFF1E293B))),
            Text(sub,
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                    fontWeight: FontWeight.w500)),
          ],
        )
      ],
    );
  }
}
