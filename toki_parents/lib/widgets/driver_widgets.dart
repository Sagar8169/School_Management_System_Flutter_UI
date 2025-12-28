// lib/widgets/driver_widgets.dart
import 'package:flutter/material.dart';

class DriverWidgets {
  // Colors
  static const Color primaryColor = Color(0xFFE65100);
  static const Color primaryLight = Color(0xFFFF9800);
  static const Color scaffoldBackground = Color(0xFFF6F7FB);
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color infoColor = Color(0xFF3B82F6);

  // Text Styles
  static TextStyle headlineLarge({Color? color}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: color ?? textPrimary,
    );
  }

  static TextStyle headlineMedium({Color? color}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: color ?? textPrimary,
    );
  }

  static TextStyle titleLarge({Color? color}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: color ?? textPrimary,
    );
  }

  static TextStyle titleMedium({Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: color ?? textPrimary,
    );
  }

  static TextStyle titleSmall({Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: color ?? textPrimary,
    );
  }

  static TextStyle bodyLarge({Color? color}) {
    return TextStyle(
      fontSize: 16,
      color: color ?? textPrimary,
    );
  }

  static TextStyle bodyMedium({Color? color}) {
    return TextStyle(
      fontSize: 14,
      color: color ?? textPrimary,
    );
  }

  static TextStyle bodySmall({Color? color}) {
    return TextStyle(
      fontSize: 12,
      color: color ?? textSecondary,
    );
  }

  static TextStyle caption({Color? color}) {
    return TextStyle(
      fontSize: 11,
      color: color ?? textSecondary,
    );
  }

  // Widgets
  static Widget card({
    required Widget child,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          border: border,
          boxShadow: boxShadow ?? [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  static Widget iconCircle({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    double size = 40,
    double iconSize = 20,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: iconSize),
    );
  }

  static Widget badge({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static Widget alertBanner({
    required String title,
    required String message,
    required VoidCallback onDismiss,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? warningColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: warningColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: warningColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: bodyMedium(color: warningColor).copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(message, style: bodySmall(color: warningColor)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onDismiss,
            child: Icon(Icons.close, color: warningColor, size: 20),
          ),
        ],
      ),
    );
  }

  static Widget appHeader({
    required String schoolName,
    required String schoolInitial,
    required String selectedLanguage,
    required VoidCallback onLanguageToggle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                schoolInitial,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  schoolName,
                  style: titleMedium(),
                ),
                Text(
                  'Driver Portal',
                  style: caption(),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onLanguageToggle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: borderColor),
              ),
              child: Text(
                selectedLanguage,
                style: bodySmall().copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}