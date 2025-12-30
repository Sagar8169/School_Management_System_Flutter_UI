import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class AssignTaskPage extends StatefulWidget {
  const AssignTaskPage({super.key});

  @override
  State<AssignTaskPage> createState() => _AssignTaskPageState();
}

class _AssignTaskPageState extends State<AssignTaskPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // int _currentIndex = 2;
  bool _isTelugu = false;
  bool _isAssigning = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  DateTime? _selectedDate;

  List<Map<String, dynamic>> _tasks = [
    {
      'id': '1',
      'title': 'Submit Monthly Report',
      'teacher': 'Anjali Sharma',
      'date': '24/12/2025',
      'status': 'pending',
      'desc': 'Detailed report for Class 5A attendance and grades.',
      'selectedTeacherNames': ['Anjali Sharma']
    },
  ];

  final List<Map<String, dynamic>> _teachers = [
    {'name': 'Anjali Sharma', 'class': 'Class 5A', 'isSelected': false},
    {'name': 'Rohan Verma', 'class': 'Class 8B', 'isSelected': false},
    {'name': 'Priya Singh', 'class': 'Class 3C', 'isSelected': false},
    {'name': 'Sameer Khan', 'class': 'Physical Education', 'isSelected': false},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // --- LOGIC: Task History Update ---
  void _openEditTaskForm(Map<String, dynamic> task) {
    final TextEditingController editTitle =
        TextEditingController(text: task['title']);
    final TextEditingController editDesc =
        TextEditingController(text: task['desc']);
    DateTime? editDate = DateTime.now();

    List<Map<String, dynamic>> tempTeachers = _teachers.map((t) {
      return {
        'name': t['name'],
        'class': t['class'],
        'isSelected': task['selectedTeacherNames'].contains(t['name']),
      };
    }).toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Zaroori hai keyboard adjustment ke liye
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          padding: EdgeInsets.only(
            top: 15,
            left: 20,
            right: 20,
            // ✨ KEYBOARD FIX: Ye line button ko keyboard ke upar rakhti hai
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Content ke hisab se height lega
            children: [
              Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Edit Task Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded)),
                ],
              ),
              const Divider(),
              // ✨ SCROLLABLE AREA: Form content scroll ho sakega
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildInputFields(editTitle, editDesc, editDate,
                          (d) => setModalState(() => editDate = d)),
                      const SizedBox(height: 15),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Update Teachers",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      const SizedBox(height: 10),
                      ...tempTeachers
                          .map((t) => CheckboxListTile(
                                value: t['isSelected'],
                                onChanged: (v) =>
                                    setModalState(() => t['isSelected'] = v!),
                                title: Text(t['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                subtitle: Text(t['class'],
                                    style: const TextStyle(fontSize: 12)),
                                activeColor: const Color(0xFF1D4ED8),
                                contentPadding: EdgeInsets.zero,
                              ))
                          .toList(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ✨ FIXED BUTTON: Hamesha bottom par visible rahega
              _buildUpdateBtn(task['id'], editTitle, editDesc, tempTeachers),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildOriginalHeader(),
            TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF1D4ED8),
              indicatorColor: const Color(0xFF1D4ED8),
              tabs: const [Tab(text: "Assign New"), Tab(text: "History")],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildAssignTab(), _buildHistoryTab()],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildModernBottomNav(),
    );
  }

  Widget _buildAssignTab() {
    return Container(
      color: const Color(0xFFF8FAFC), // Halka slate background
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION 1: TASK DETAILS ---
            _sectionHeader("Task Information", Icons.edit_document),
            const SizedBox(height: 12),
            _buildInputFields(
              _titleController,
              _descController,
              _selectedDate,
              (d) => setState(() => _selectedDate = d),
            ),

            const SizedBox(height: 30),

            // --- SECTION 2: TEACHER SELECTION ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sectionHeader(
                    "Select Staff / Teachers", Icons.people_alt_rounded),
                Text(
                  "${_teachers.where((t) => t['isSelected']).length} Selected",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1D4ED8),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _teachers.length,
                separatorBuilder: (_, __) => const Divider(
                  height: 1,
                  indent: 70,
                  endIndent: 20,
                  color: Color(0xFFF1F5F9),
                ),
                itemBuilder: (context, index) {
                  final t = _teachers[index];
                  final isSelected = t['isSelected'];

                  return InkWell(
                    onTap: () => setState(() => t['isSelected'] = !isSelected),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: isSelected
                                ? const Color(0xFF1D4ED8)
                                : const Color(0xFFF1F5F9),
                            child: Text(
                              t['name'][0],
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF1D4ED8),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t['name'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: isSelected
                                        ? const Color(0xFF1D4ED8)
                                        : const Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  t['class'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? const Color(0xFF1D4ED8)
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF1D4ED8)
                                    : const Color(0xFFCBD5E1),
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(Icons.check,
                                    size: 16, color: Colors.white)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),

            // --- SECTION 3: SUBMIT ---
            _buildSubmitBtn(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Helper for Section Titles
  Widget _sectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF1D4ED8)),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: Color(0xFF64748B),
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTab() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(tabs: [Tab(text: "Pending"), Tab(text: "Done")]),
          Expanded(
              child: TabBarView(children: [
            _buildTaskList(
                _tasks.where((t) => t['status'] == 'pending').toList(), true),
            _buildTaskList(
                _tasks.where((t) => t['status'] == 'completed').toList(),
                false),
          ])),
        ],
      ),
    );
  }

  Widget _buildTaskList(List<Map<String, dynamic>> list, bool isPending) {
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment_turned_in_rounded,
                size: 60, color: Colors.grey.shade200),
            const SizedBox(height: 12),
            Text("No tasks found",
                style: TextStyle(
                    color: Colors.grey.shade400, fontWeight: FontWeight.w600)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding:
          const EdgeInsets.fromLTRB(16, 8, 16, 80), // Bottom padding for FAB
      itemCount: list.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final task = list[index];
        final Color statusColor =
            isPending ? const Color(0xFFF59E0B) : const Color(0xFF10B981);

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            // --- SUBTLE BORDER & SHADOW ---
            border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E293B).withOpacity(0.02),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              children: [
                // --- TOP ACCENT BAR ---
                Container(
                    height: 4,
                    width: double.infinity,
                    color: statusColor.withOpacity(0.4)),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --- ICON INDICATOR ---
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              isPending
                                  ? Icons.timer_outlined
                                  : Icons.check_circle_outline_rounded,
                              color: statusColor,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          // --- TITLE & TEACHER ---
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task['title'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF1E293B),
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 9,
                                      backgroundColor: Colors.blue.shade50,
                                      child: const Icon(Icons.person,
                                          size: 10, color: Color(0xFF1D4ED8)),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      task['teacher'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // --- ACTIONS ---
                          if (isPending) _buildActionMenu(task),
                        ],
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                      ),

                      // --- BOTTOM META DATA ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Priority Badge
                          _taskTag(
                            isPending ? "HIGH PRIORITY" : "COMPLETED",
                            isPending
                                ? Colors.red.shade700
                                : Colors.green.shade700,
                            isPending
                                ? Colors.red.shade50
                                : Colors.green.shade50,
                          ),
                          // Date/Deadline
                          Row(
                            children: [
                              Icon(Icons.calendar_today_rounded,
                                  size: 12, color: Colors.grey.shade400),
                              const SizedBox(width: 4),
                              Text(
                                "Due 28 Dec",
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _taskTag(String label, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration:
          BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
      child: Text(
        label,
        style: TextStyle(
            color: textColor,
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildActionMenu(Map<String, dynamic> task) {
    return PopupMenuButton(
      icon:
          Icon(Icons.more_vert_rounded, color: Colors.grey.shade400, size: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onSelected: (val) {
        if (val == 'edit') _openEditTaskForm(task);
        if (val == 'done') _markDone(task['id']);
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
            value: 'edit',
            child: Row(children: [
              Icon(Icons.edit_outlined, size: 18),
              SizedBox(width: 8),
              Text("Edit")
            ])),
        const PopupMenuItem(
            value: 'done',
            child: Row(children: [
              Icon(Icons.done_all_rounded, size: 18, color: Colors.green),
              SizedBox(width: 8),
              Text("Close Task")
            ])),
      ],
    );
  }
  // --- REUSABLE HELPERS ---

  Widget _buildInputFields(
    TextEditingController t,
    TextEditingController d,
    DateTime? dt,
    Function(DateTime) onPick,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- TITLE FIELD ---
        _fieldLabel("Task Title"),
        const SizedBox(height: 6),
        _inputCard(
          child: TextField(
            controller: t,
            textInputAction: TextInputAction.next,
            decoration: _inputDeco(
              Icons.title_rounded,
              "Enter task title",
            ),
          ),
        ),

        const SizedBox(height: 18),

        // --- DESCRIPTION FIELD ---
        _fieldLabel("Description"),
        const SizedBox(height: 6),
        _inputCard(
          child: TextField(
            controller: d,
            maxLines: 4,
            decoration: _inputDeco(
              Icons.description_rounded,
              "Write task details",
            ),
          ),
        ),

        const SizedBox(height: 20),

        // --- DATE PICKER ---
        _fieldLabel("Due Date"),
        const SizedBox(height: 6),
        _inputCard(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2026),
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
              if (picked != null) onPick(picked);
            },
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.event_rounded,
                    color: Color(0xFF1D4ED8),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    dt == null
                        ? "Select due date"
                        : "${dt.day.toString().padLeft(2, '0')}/"
                            "${dt.month.toString().padLeft(2, '0')}/"
                            "${dt.year}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: dt == null
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF0F172A),
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF94A3B8),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _inputCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: Color(0xFF64748B),
        letterSpacing: 0.4,
      ),
    );
  }

  Widget _buildUpdateBtn(
    String id,
    TextEditingController t,
    TextEditingController d,
    List<Map<String, dynamic>> tList,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 34), // 👈 yaha gap milega
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1D4ED8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: () {
            setState(() {
              final i = _tasks.indexWhere((task) => task['id'] == id);
              List<String> selected = tList
                  .where((t) => t['isSelected'])
                  .map((t) => t['name'] as String)
                  .toList();

              if (i != -1) {
                _tasks[i]['title'] = t.text;
                _tasks[i]['desc'] = d.text;
                _tasks[i]['teacher'] = selected.join(", ");
                _tasks[i]['selectedTeacherNames'] = selected;
              }
            });
            Navigator.pop(context);
          },
          child: const Text(
            "Save Changes",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitBtn() {
    return SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1D4ED8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          onPressed: () {
            // Create Logic
          },
          child: const Text("Assign Task",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ));
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

          // 📝 Title
          const Expanded(
            child: Text(
              'Assign Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
              ),
            ),
          ),

          // 🌐 Language Pill (existing)
          _buildLanguagePill(),
        ],
      ),
    );
  }

  Widget _buildLanguagePill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(20)),
      child: Text(_isTelugu ? 'తెలుగు' : 'English',
          style: const TextStyle(
              color: Color(0xFF1D4ED8), fontWeight: FontWeight.bold)),
    );
  }

  void _onBottomNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, PrincipalRoutes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, PrincipalRoutes.search);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, PrincipalRoutes.activity);
        break;
      case 3:
        Navigator.pushReplacementNamed(
          context,
          PrincipalRoutes.morePage,
          arguments: {'section': null},
        );
        break;
    }
  }

  InputDecoration _inputDeco(IconData i, String h) => InputDecoration(
      prefixIcon: Icon(i, size: 20, color: const Color(0xFF1D4ED8)),
      hintText: h,
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none));

  void _markDone(String id) {
    setState(() {
      final i = _tasks.indexWhere((t) => t['id'] == id);
      if (i != -1) _tasks[i]['status'] = 'completed';
    });
  }

  // Widget _buildModernBottomNav() {
  //   return BottomNavigationBar(
  //     currentIndex: _currentIndex,
  //     onTap: (i) => setState(() => _currentIndex = i),
  //     type: BottomNavigationBarType.fixed,
  //     selectedItemColor: const Color(0xFF1D4ED8),
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
