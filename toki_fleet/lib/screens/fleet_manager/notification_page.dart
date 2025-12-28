import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Dummy Data List
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'Bus Maintenance Due',
      'desc': 'Bus AP09T1234 requires scheduled oiling and brake checkup.',
      'time': '2 mins ago',
      'type': 'warning',
      'isUnread': true,
      'group': 'Today',
    },
    {
      'id': '2',
      'title': 'Route Diverted',
      'desc': 'Route 4 has been diverted due to heavy traffic at Banjara Hills.',
      'time': '1 hour ago',
      'type': 'alert',
      'isUnread': true,
      'group': 'Today',
    },
    {
      'id': '3',
      'title': 'Shift Completed',
      'desc': 'All morning shifts were completed successfully without delays.',
      'time': '10:30 AM',
      'type': 'success',
      'isUnread': false,
      'group': 'Yesterday',
    },
    {
      'id': '4',
      'title': 'New Driver Assigned',
      'desc': 'Ramesh Babu has been assigned to Route 12 under your fleet.',
      'time': '09:15 AM',
      'type': 'info',
      'isUnread': false,
      'group': 'Yesterday',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Softer grey background
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E293B),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                for (var n in _notifications) {
                  n['isUnread'] = false;
                }
              });
            },
            icon: const Icon(Icons.done_all_rounded, size: 22),
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final item = _notifications[index];
          bool showHeader = false;

          // Logic to show grouping header (Today/Yesterday)
          if (index == 0 || _notifications[index - 1]['group'] != item['group']) {
            showHeader = true;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showHeader) _buildSectionHeader(item['group']),
              _buildDismissibleTile(item),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 16, left: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFF64748B),
          fontWeight: FontWeight.w800,
          fontSize: 12,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildDismissibleTile(Map<String, dynamic> item) {
    return Dismissible(
      key: Key(item['id']),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          _notifications.removeWhere((element) => element['id'] == item['id']);
        });
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 30),
      ),
      child: _buildNotificationCard(item),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> item) {
    Color themeColor;
    IconData iconData;

    // Type checking for UI variation
    switch (item['type']) {
      case 'warning':
        themeColor = const Color(0xFFF59E0B);
        iconData = Icons.engineering_rounded;
        break;
      case 'alert':
        themeColor = const Color(0xFFEF4444);
        iconData = Icons.alt_route_rounded;
        break;
      case 'success':
        themeColor = const Color(0xFF10B981);
        iconData = Icons.task_alt_rounded;
        break;
      default:
        themeColor = const Color(0xFF3B82F6);
        iconData = Icons.notifications_none_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: item['isUnread'] ? themeColor.withOpacity(0.3) : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          setState(() => item['isUnread'] = false);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stylish Icon Container
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [themeColor.withOpacity(0.1), themeColor.withOpacity(0.2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: themeColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: item['isUnread'] ? const Color(0xFF0F172A) : const Color(0xFF64748B),
                            ),
                          ),
                        ),
                        if (item['isUnread'])
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(color: themeColor, shape: BoxShape.circle),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['desc'],
                      style: TextStyle(
                        color: const Color(0xFF475569),
                        fontSize: 13,
                        height: 1.4,
                        fontWeight: item['isUnread'] ? FontWeight.w500 : FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item['time'],
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text(
            'All caught up!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const Text('No new notifications for you.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}