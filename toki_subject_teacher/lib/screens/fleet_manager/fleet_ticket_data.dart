class FleetTicket {
  final String id;
  final String title;
  final String description;
  final String type;        // e.g. Maintenance
  final String status;      // e.g. In Progress
  final String priority;    // e.g. High
  final String busNumber;   // e.g. KA-01-AB-1234
  final String routeName;   // e.g. Route 1
  final String reportedBy;
  final String reportedByRole;
  final String createdDate;
  final String footerDate;
  final String updateAuthor;
  final String updateMessage;
  final String updateTimestamp;

  const FleetTicket({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.priority,
    required this.busNumber,
    required this.routeName,
    required this.reportedBy,
    required this.reportedByRole,
    required this.createdDate,
    required this.footerDate,
    required this.updateAuthor,
    required this.updateMessage,
    required this.updateTimestamp,
  });
}

class FleetTicketData {
  static const tickets = <FleetTicket>[
    FleetTicket(
      id: 'T101',
      title: 'Bus AC Not Working',
      description:
      'Driver reported that the AC in Bus KA-01-AB-1234 is not functioning properly. '
          'Students are experiencing discomfort during the morning route. Please arrange an AC technician '
          'to inspect and fix the issue before the next working day.',
      type: 'Maintenance',
      status: 'In Progress',
      priority: 'High',
      busNumber: 'KA-01-AB-1234',
      routeName: 'Route 1',
      reportedBy: 'Mr. Ramesh Kumar',
      reportedByRole: 'Driver',
      createdDate: 'Nov 8, 2025',
      footerDate: 'Nov 8, 2025',
      updateAuthor: 'Maintenance Team',
      updateMessage:
      'AC technician has been assigned. Will check the bus tomorrow morning.',
      updateTimestamp: 'Nov 8, 3:30 PM',
    ),
  ];

  static FleetTicket? getById(String id) {
    try {
      return tickets.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }
}
