import 'package:flutter/material.dart';

class FleetTripsPage extends StatelessWidget {
  final String? shift;
  final String? date;

  const FleetTripsPage({Key? key, this.shift, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fleet Trips")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Trips Page"),
            if (shift != null) Text("Shift: $shift"),
            if (date != null) Text("Date: $date"),
          ],
        ),
      ),
    );
  }
}
