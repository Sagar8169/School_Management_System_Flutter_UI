import 'package:flutter/material.dart';
import '../routes.dart';
import '../routes/subject_teacher_routes.dart';

class OtpVerificationPage extends StatefulWidget {
  final String mobileNumber;

  const OtpVerificationPage({
    Key? key,
    required this.mobileNumber,
  }) : super(key: key);

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  void _verifyOTP() {
    String otp = _otpController.text.trim();

    if (otp.length != 6) {
      _showSnackBar(
        'Please enter complete 6-digit OTP',
        const Color(0xFFE11D48),
      );
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isLoading = false);

      // 🚍 ONLY DRIVER LOGIN ALLOWED
      // 👨‍👩‍👧 ONLY PARENTS LOGIN ALLOWED
      if (otp == '333333') {
        Navigator.pushReplacementNamed(
          context,
          SubjectTeacherRoutes.home,
        );
      }


    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ✨ Top Background Decoration (Matching Login Page)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.40,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1D4ED8), Color(0xFF1E3A8A)],
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Back Button Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Header Info
                  Text(
                    'OTP Verification'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 2,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Sunrise High School',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white),
                  ),

                  const SizedBox(height: 50),

                  // ✨ Verification Card
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Verify OTP',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            text: 'We sent a 6-digit code to ',
                            style: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
                            children: [
                              TextSpan(
                                text: widget.mobileNumber,
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1D4ED8)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),

                        // OTP Input Container
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 12,
                              color: Color(0xFF1E3A8A),
                            ),
                            decoration: const InputDecoration(
                              counterText: '',
                              hintText: '●●●●●●',
                              hintStyle: TextStyle(color: Color(0xFFCBD5E1), letterSpacing: 12),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 20),
                            ),
                          ),
                        ),

                        const SizedBox(height: 35),

                        // Verify Button
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _verifyOTP,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1D4ED8),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                            )
                                : const Text('Verify & Proceed', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Resend Section
                        Center(
                          child: TextButton(
                            onPressed: () {
                              _otpController.clear();
                              _showSnackBar('OTP has been resent!', const Color(0xFF10B981));
                            },
                            child: const Text(
                              "Didn't receive code? Resend",
                              style: TextStyle(color: Color(0xFF1D4ED8), fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Powered by Branding
                  Column(
                    children: [
                      const Text('Powered by', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'TOKI TECH',
                          style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF64748B), letterSpacing: 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}