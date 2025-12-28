import 'package:flutter/material.dart';

// 1. Model Class (Isko top pe rakho)
class FleetTicket {
  final String id;
  final String title;
  final String description;
  final String type;
  final String status;
  final String priority;
  final String busNumber;
  final String routeName;
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

// 2. Data Class
class FleetTicketData {
  static const tickets = <FleetTicket>[
    FleetTicket(
      id: 'T101',
      title: 'Bus AC Not Working',
      description: 'Driver reported that the AC in Bus KA-01-AB-1234 is not functioning properly. Students are experiencing discomfort.',
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
      updateMessage: 'AC technician has been assigned. Will check the bus tomorrow morning.',
      updateTimestamp: 'Nov 8, 3:30 PM',
    ),
    FleetTicket(
      id: 'T102',
      title: 'Tyre Pressure Low',
      description: 'Rear left tyre losing pressure frequently.',
      type: 'Maintenance',
      status: 'Pending',
      priority: 'Medium',
      busNumber: 'KA-01-AB-5678',
      routeName: 'Route 5',
      reportedBy: 'Suresh Raina',
      reportedByRole: 'Driver',
      createdDate: 'Nov 9, 2025',
      footerDate: 'Nov 9, 2025',
      updateAuthor: 'Fleet Manager',
      updateMessage: 'Checking for puncture.',
      updateTimestamp: 'Nov 9, 10:00 AM',
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