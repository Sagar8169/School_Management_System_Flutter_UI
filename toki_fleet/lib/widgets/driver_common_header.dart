import 'package:flutter/material.dart';

class DriverCommonHeader extends StatelessWidget {
  final bool isTelugu;
  final VoidCallback? onBack;
  final String? title;

  const DriverCommonHeader({
    super.key,
    this.isTelugu = true,
    this.onBack,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // School Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE67E22).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "A",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aditya International School',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'Powered by Toki Tech',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  isTelugu ? 'తెలుగు' : 'English',
                  style: const TextStyle(
                    color: Color(0xFFE67E22),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Optional Back + Title
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (onBack != null)
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: onBack,
                    ),
                  ),
                const SizedBox(width: 16),
                Text(
                  title!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
