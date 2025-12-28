import 'package:flutter/material.dart';

class FleetMaintenance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Maintenance"), backgroundColor: Colors.orange),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.build_circle, size: 80, color: Colors.orange.withOpacity(0.5)),
          SizedBox(height: 20),
          Text("Upcoming Services", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text("No urgent service needed for today", style: TextStyle(color: Colors.grey)),
        ],
      )),
    );
  }
}