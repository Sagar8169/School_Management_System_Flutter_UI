import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: CommonWidgets.primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: CommonWidgets.primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              '$title Page',
              style: CommonWidgets.headlineMedium(),
            ),
            const SizedBox(height: 8),
            Text(
              'This page is under development',
              style: CommonWidgets.bodyMedium(color: CommonWidgets.textSecondary),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CommonWidgets.primaryColor,
              ),
              child: Text(
                'Go Back',
                style: CommonWidgets.bodyMedium(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}