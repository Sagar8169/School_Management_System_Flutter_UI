import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  // int _currentIndex = 2; // Activity index
  bool _isTelugu = false;
  bool _isPublishing = false;

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _customEventController = TextEditingController();

  String _selectedEventType = 'Sports Day';
  DateTime _eventDate = DateTime.now().add(const Duration(days: 7));
  TimeOfDay _eventTime = const TimeOfDay(hour: 9, minute: 0);

  // Audience Checkboxes
  bool _notifyTeachers = true;
  bool _notifyStudents = true;
  bool _notifyParents = true;

  final List<String> _eventTypes = [
    'Sports Day',
    'Cultural Fest',
    'Parent-Teacher Meeting',
    'Annual Day',
    'Holiday Notice',
    'Examination',
    'Custom Event' // Naya option
  ];

  // --- LOGIC FUNCTIONS ---
  void _toggleLanguage() => setState(() => _isTelugu = !_isTelugu);

  Future<void> _selectDate() async {
    final DateTime today = DateTime.now();
    final DateTime lastAllowedDate = DateTime(2026, 1, 1);

    // ✅ Ensure initialDate is ALWAYS valid
    final DateTime safeInitialDate =
        _eventDate.isAfter(lastAllowedDate) ? lastAllowedDate : _eventDate;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: safeInitialDate,
      firstDate: today,
      lastDate: lastAllowedDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1D4ED8),
              onPrimary: Colors.white,
              onSurface: Color(0xFF0F172A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _eventDate = picked);
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _eventTime,
    );
    if (picked != null) setState(() => _eventTime = picked);
  }

  void _publishEvent() {
    String finalTitle = _titleController.text;

    // Validation
    if (finalTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter event title"),
          behavior: SnackBarBehavior.floating));
      return;
    }

    if (_selectedEventType == 'Custom Event' &&
        _customEventController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter custom event name"),
          behavior: SnackBarBehavior.floating));
      return;
    }

    setState(() => _isPublishing = true);

    // Simulate Notification Sending to all apps
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isPublishing = false);
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E293B).withOpacity(0.12),
                blurRadius: 30,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔔 SUCCESS ICON
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1D4ED8), Color(0xFF2563EB)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1D4ED8).withOpacity(0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.notifications_active_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),

              const SizedBox(height: 22),

              // ✅ TITLE
              const Text(
                "Event Published!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                ),
              ),

              const SizedBox(height: 10),

              // 📄 DESCRIPTION
              Text(
                "Notifications have been successfully sent to all selected teachers, students, and parents.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 26),

              // ✅ DONE BUTTON
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D4ED8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildOriginalHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader("1", "Event Information"),
                    _buildEventInfoCard(),
                    const SizedBox(height: 25),
                    _buildSectionHeader("2", "Audience & Notifications"),
                    _buildAudienceCard(),
                    const SizedBox(height: 35),
                    _buildPublishButton(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildScreenshotBottomNav(),
    );
  }

  Widget _buildOriginalHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 0,
        20,
        10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6), // 👈 shadow only at bottom
          ),
        ],
      ),
      child: Row(
        children: [
          // 🔙 Circular Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 42,
              width: 42,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xFF1D4ED8),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // 🏫 Title + Subtitle
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Attendance Log',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Aditya International School',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          // 🌐 Language Toggle
          GestureDetector(
            onTap: () => setState(() => _isTelugu = !_isTelugu),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1D4ED8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenshotHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios,
                    color: Color(0xFF1D4ED8), size: 22),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Add School Event',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B))),
                  const SizedBox(height: 2),
                  Text('Aditya International School',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: _toggleLanguage,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(30)),
              child: Text(_isTelugu ? 'తెలుగు' : 'English',
                  style: const TextStyle(
                      color: Color(0xFF1D4ED8),
                      fontWeight: FontWeight.w700,
                      fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 4),
      child: Row(
        children: [
          CircleAvatar(
              radius: 11,
              backgroundColor: const Color(0xFFFBBF24),
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold))),
          const SizedBox(width: 10),
          Text(text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey.shade800)),
        ],
      ),
    );
  }

  Widget _buildEventInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        // ✅ CLEAN LIGHT BORDER (card ke edge par)
        border: Border.all(
          color: const Color(0xFFE2E8F0), // light slate border
          width: 1,
        ),

        // optional soft depth (border overpower na ho)
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel("Event Category"),
          DropdownButtonFormField<String>(
            value: _selectedEventType,
            decoration: _inputDeco(Icons.category_rounded),
            items: _eventTypes
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => setState(() => _selectedEventType = v!),
          ),
          if (_selectedEventType == 'Custom Event') ...[
            const SizedBox(height: 16),
            _buildLabel("Custom Event Name"),
            TextField(
              controller: _customEventController,
              decoration: _inputDeco(
                Icons.edit_calendar_rounded,
                hint: "Enter your event name",
              ),
            ),
          ],
          const SizedBox(height: 16),
          _buildLabel("Event Title / Heading"),
          TextField(
            controller: _titleController,
            decoration: _inputDeco(
              Icons.title_rounded,
              hint: "e.g. Annual Sports Day 2025",
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Date"),
                    InkWell(
                      onTap: _selectDate,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: _boxDeco(),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 18, color: Color(0xFF1D4ED8)),
                            const SizedBox(width: 8),
                            Text(
                              "${_eventDate.day}/${_eventDate.month}/${_eventDate.year}",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Time"),
                    InkWell(
                      onTap: _selectTime,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: _boxDeco(),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 18, color: Color(0xFF1D4ED8)),
                            const SizedBox(width: 8),
                            Text(_eventTime.format(context)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildLabel("Short Description"),
          TextField(
            controller: _descController,
            maxLines: 3,
            decoration: _inputDeco(
              Icons.description_rounded,
              hint: "Enter event details...",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudienceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        // ✅ PROPER CARD BORDER (andar wali edge pe)
        border: Border.all(
          color: const Color(0xFFE2E8F0), // light slate (perfect)
          width: 1,
        ),

        // optional subtle depth (recommended)
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _audienceTile(
            "Teachers App",
            Icons.school_rounded,
            _notifyTeachers,
            (v) => setState(() => _notifyTeachers = v!),
          ),
          _audienceTile(
            "Students App",
            Icons.face_rounded,
            _notifyStudents,
            (v) => setState(() => _notifyStudents = v!),
          ),
          _audienceTile(
            "Parents App",
            Icons.family_restroom_rounded,
            _notifyParents,
            (v) => setState(() => _notifyParents = v!),
          ),
        ],
      ),
    );
  }

  Widget _audienceTile(
      String title, IconData icon, bool val, Function(bool?) onCh) {
    return CheckboxListTile(
      value: val,
      onChanged: onCh,
      activeColor: const Color(0xFF1D4ED8),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      secondary: Icon(icon, color: const Color(0xFF1D4ED8)),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildPublishButton() {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color(0xFF1D4ED8).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8))
      ]),
      child: ElevatedButton(
        onPressed: _isPublishing ? null : _publishEvent,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1D4ED8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 0),
        child: _isPublishing
            ? const CircularProgressIndicator(
                color: Colors.white, strokeWidth: 3)
            : const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.send_rounded, color: Colors.white),
                SizedBox(width: 10),
                Text("Publish & Notify All",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 16))
              ]),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 2),
      child: Text(text,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey)));

  InputDecoration _inputDeco(IconData icon, {String? hint}) => InputDecoration(
        prefixIcon: Icon(icon, size: 20, color: const Color(0xFF1D4ED8)),
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      );

  BoxDecoration _boxDeco() => BoxDecoration(
      color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12));

  // Widget _buildScreenshotBottomNav() {
  //   return BottomNavigationBar(
  //     currentIndex: _currentIndex,
  //     onTap: _onBottomNavTap,
  //     type: BottomNavigationBarType.fixed,
  //     selectedItemColor: const Color(0xFF1D4ED8),
  //     unselectedItemColor: const Color(0xFF64748B),
  //     items: const [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home_rounded),
  //         label: "Home",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.search_rounded),
  //         label: "Search",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.analytics_rounded),
  //         label: "Activity",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.grid_view_rounded),
  //         label: "More",
  //       ),
  //     ],
  //   );
  // }
}
