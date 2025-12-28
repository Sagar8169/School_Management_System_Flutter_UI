import 'package:flutter/material.dart';

class FleetRoute {
  final String id;
  final String name;
  final int studentsCount;
  final int driversCount;

  FleetRoute({
    required this.id,
    required this.name,
    required this.studentsCount,
    required this.driversCount,
  });

  get busNumber => null;
}

class FleetStudent {
  final String id;
  final String name;
  final String className;
  final String rollNo;
  final String locationName;
  final String routeId;

  FleetStudent({
    required this.id,
    required this.name,
    required this.className,
    required this.rollNo,
    required this.locationName,
    required this.routeId,
  });
}

class FleetDriver {
  final String id;
  final String name;
  final bool onDuty;
  final String busPlate;
  final int experienceYears;
  final String phone;
  final String routeId;

  FleetDriver({
    required this.id,
    required this.name,
    required this.onDuty,
    required this.busPlate,
    required this.experienceYears,
    required this.phone,
    required this.routeId,
  });
}

class FleetMockData {
  static final routes = <FleetRoute>[
    FleetRoute(
      id: 'route1',
      name: 'Route 1 - North Zone',
      studentsCount: 45,
      driversCount: 2,
    ),
    FleetRoute(
      id: 'route2',
      name: 'Route 2 - South Zone',
      studentsCount: 52,
      driversCount: 2,
    ),
    FleetRoute(
      id: 'route3',
      name: 'Route 3 - East Zone',
      studentsCount: 38,
      driversCount: 1,
    ),
  ];

  static final students = <FleetStudent>[
    FleetStudent(
      id: 'stu1',
      name: 'Rahul Sharma',
      className: '10 A',
      rollNo: '12',
      locationName: 'Madhapur',
      routeId: 'route1',
    ),
    FleetStudent(
      id: 'stu2',
      name: 'Ananya Verma',
      className: '9 B',
      rollNo: '7',
      locationName: 'Kukatpally',
      routeId: 'route1',
    ),
    FleetStudent(
      id: 'stu3',
      name: 'Rohan Singh',
      className: '8 C',
      rollNo: '21',
      locationName: 'Secunderabad',
      routeId: 'route2',
    ),
    FleetStudent(
      id: 'stu4',
      name: 'Priya Nair',
      className: '7 A',
      rollNo: '5',
      locationName: 'Gachibowli',
      routeId: 'route3',
    ),
  ];

  static final drivers = <FleetDriver>[
    FleetDriver(
      id: 'drv1',
      name: 'Mr. Ramesh Kumar',
      onDuty: true,
      busPlate: 'KA-01-AB-1234',
      experienceYears: 8,
      phone: '+91 98765 43210',
      routeId: 'route1',
    ),
    FleetDriver(
      id: 'drv2',
      name: 'Mr. S. Prasad',
      onDuty: false,
      busPlate: 'KA-01-CD-5678',
      experienceYears: 5,
      phone: '+91 98765 11111',
      routeId: 'route1',
    ),
    FleetDriver(
      id: 'drv3',
      name: 'Mr. Ajay Rao',
      onDuty: true,
      busPlate: 'KA-02-EF-9012',
      experienceYears: 6,
      phone: '+91 98765 22222',
      routeId: 'route2',
    ),
    FleetDriver(
      id: 'drv4',
      name: 'Mr. Vinod Patil',
      onDuty: true,
      busPlate: 'KA-03-GH-3456',
      experienceYears: 4,
      phone: '+91 98765 33333',
      routeId: 'route3',
    ),
  ];

  static List<FleetStudent> studentsForRoute(String routeId) {
    return students.where((s) => s.routeId == routeId).toList();
  }

  static List<FleetDriver> driversForRoute(String routeId) {
    return drivers.where((d) => d.routeId == routeId).toList();
  }

  static FleetRoute? routeById(String routeId) {
    try {
      return routes.firstWhere((r) => r.id == routeId);
    } catch (_) {
      return null;
    }
  }

  static FleetDriver? driverById(String driverId) {
    try {
      return drivers.firstWhere((d) => d.id == driverId);
    } catch (_) {
      return null;
    }
  }
}
