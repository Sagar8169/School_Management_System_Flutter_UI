import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toki/routes/subject_teacher_routes.dart';
import '../../routes.dart';
import '../../widgets/common_widgets.dart';
import '../mobile_login_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MorePage extends StatefulWidget {
  final String? initialSection;
  const MorePage({super.key, this.initialSection});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
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
      'hasBadge': true,
      'badgeCount': 6,
      'badgeColor': Colors.orange
    },
    {
      'title': 'Tickets',
      'id': 'tickets',
      'icon': Icons.confirmation_number_outlined,
      'color': Colors.purple,
      'hasBadge': true,
      'badgeCount': 8,
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
      'hasBadge': true,
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

  // --- Navigation Logic ---

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
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 25),
              const Text("Contact Support",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              _buildContactTile(
                  "Call Support",
                  "+91 98765 43210",
                  Icons.call_rounded,
                  Colors.green,
                  () => _handleAction("tel:+919876543210")),
              const SizedBox(height: 15),
              _buildContactTile(
                  "Email Support",
                  "support@tokitech.com",
                  Icons.alternate_email_rounded,
                  Colors.blue,
                  () => _handleAction("mailto:support@tokitech.com")),
            ],
          ),
        ),
      ),
    );
  }

  void _editProfile() {
    TextEditingController nameCtrl = TextEditingController(text: principalName);
    File? tempImage = _profileImage;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: const Center(
              child: Text("Edit Principal Profile",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    final XFile? img = await _picker.pickImage(
                        source: ImageSource.gallery, imageQuality: 85);
                    if (img != null)
                      setModalState(() => tempImage = File(img.path));
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blue[50],
                          backgroundImage:
                              tempImage != null ? FileImage(tempImage!) : null,
                          child: tempImage == null
                              ? const Icon(Icons.add_a_photo,
                                  color: Colors.blue, size: 30)
                              : null),
                      const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.blue,
                          child:
                              Icon(Icons.edit, color: Colors.white, size: 14)),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                TextField(
                    controller: nameCtrl,
                    decoration: _modernInputDecoration(
                        "Principal Name", Icons.person_outline)),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    principalName = nameCtrl.text;
                    _profileImage = tempImage;
                  });
                  Navigator.pop(context);
                },
                child: const Text("Save Changes")),
          ],
        ),
      ),
    );
  }

  // --- Internal Helpers ---
  void _handleItemTap(String id) {
    if (id == 'tickets')
      _showTicketForm();
    else if (id == 'contact')
      _showContactSupport();
    else if (id == 'language')
      _toggleLanguage();
    else if (id == 'about')
      _showAboutDialog();
    else
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$id feature coming soon'),
          behavior: SnackBarBehavior.floating));
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
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            CommonWidgets.appHeader(
                selectedLanguage: _isTelugu ? 'తెలుగు' : 'English',
                onLanguageToggle: _toggleLanguage),
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

  Widget _buildPreferencesSection() => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15)
            ]),
        child: Column(
          children: [
            ListTile(
                leading: _buildIconContainer(
                    Icons.dark_mode_outlined, Colors.deepPurple),
                title: const Text("Dark Mode"),
                trailing: Switch(
                    value: _isDarkMode,
                    onChanged: (v) => setState(() => _isDarkMode = v),
                    activeColor: Colors.blue)),
            const Divider(height: 1, indent: 60),
            ListTile(
                leading: _buildIconContainer(
                    Icons.file_download_outlined, Colors.brown),
                title: const Text("Download Reports"),
                trailing: const Icon(Icons.chevron_right, size: 20),
                onTap: () {}),
            const Divider(height: 1, indent: 60),
            ListTile(
                leading: _buildIconContainer(Icons.share_outlined, Colors.cyan),
                title: const Text("Share App"),
                trailing: const Icon(Icons.chevron_right, size: 20),
                onTap: () {}),
          ],
        ),
      );

  Widget _buildGroupedMenu(List<Map<String, dynamic>> items) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15)
            ]),
        child: Column(
          children: items.map((item) {
            bool isLast = items.indexOf(item) == items.length - 1;
            return Column(
              children: [
                ListTile(
                  onTap: () => _handleItemTap(item['id']),
                  leading: _buildIconContainer(item['icon'], item['color']),
                  title: Text(item['title'],
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  trailing: item['hasBadge'] == true
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: item['badgeColor'],
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(item['badgeCount'].toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)))
                      : const Icon(Icons.chevron_right,
                          size: 18, color: Colors.grey),
                ),
                if (!isLast)
                  const Divider(
                      height: 1, indent: 60, color: Color(0xFFF1F5F9)),
              ],
            );
          }).toList(),
        ),
      );

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

  void _showAboutDialog() {
    showAboutDialog(
        context: context,
        applicationName: "Toki Tech",
        applicationVersion: "1.0.1");
  }
}
