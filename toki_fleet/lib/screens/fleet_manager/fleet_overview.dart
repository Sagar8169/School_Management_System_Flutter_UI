import 'package:flutter/material.dart';

class FleetOverview extends StatelessWidget {
  const FleetOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fleet Overview')),
      body: const Center(child: Text('Fleet Overview Page')),
    );
  }
}