// lib/screens/parents/fees_status_page.dart
import 'package:flutter/material.dart';
import '../../routes/parents_routes.dart';

final Color _accentOrange = const Color(0xFFFF5722);
final Color _primaryOrange = const Color(0xFFFF5722);

class FeesStatusPage extends StatefulWidget {
  const FeesStatusPage({Key? key}) : super(key: key);

  @override
  _FeesStatusPageState createState() => _FeesStatusPageState();
}

class _FeesStatusPageState extends State<FeesStatusPage> {
  // ✅ ORIGINAL NAMES MAINTAINED
  String _selectedLanguage = 'తెలుగు';

  // 🎨 New Premium Soft Palette
  final Color _primaryIndigo = const Color(0xFF4338CA);
  final Color _softBg = const Color(0xFFF8FAFF);
  final Color _textMain = const Color(0xFF1E293B);
  final Color _textLight = const Color(0xFF64748B);
  final Color _paidGreen = const Color(0xFF10B981);
  final Color _dueRose = const Color(0xFFF43F5E);

  void _toggleLanguage() {
    setState(() => _selectedLanguage =
        _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు');
  }

  // --- 💳 REFINED PAYMENT MODAL ---
  void _showPaymentOptions(String feeType, String amount) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: EdgeInsets.fromLTRB(
            24, 12, 24, MediaQuery.of(context).viewPadding.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 24),
            const Text("Secure Checkout",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text("Fee Type: $feeType",
                style:
                    TextStyle(color: _textLight, fontWeight: FontWeight.w500)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [_primaryIndigo.withOpacity(0.05), Colors.white]),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: _primaryIndigo.withOpacity(0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Payable Amount",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  Text(amount,
                      style: TextStyle(
                          color: _primaryIndigo,
                          fontWeight: FontWeight.w900,
                          fontSize: 24)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildActionTile(Icons.bolt_rounded, "UPI / Google Pay",
                "Instant & 0% hidden charges", Colors.orange),
            _buildActionTile(Icons.account_balance_rounded, "Internet Banking",
                "All major banks supported", Colors.blue),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryIndigo,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("CONFIRM & PAY",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        letterSpacing: 1)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String sub, Color col) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _softBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.03)),
      ),
      child: ListTile(
        leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: col.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: col, size: 20)),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
        subtitle: Text(sub, style: TextStyle(fontSize: 11, color: _textLight)),
        trailing: const Icon(Icons.chevron_right_rounded, size: 20),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _softBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildHeroSection(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader("Current Dues"),
                          const SizedBox(height: 16),
                          _buildDueCard("Second Term Tuition Fee", "₹ 24,500",
                              "Expires in 5 days"),
                          _buildDueCard("Sports & Activity Fee", "₹ 2,200",
                              "Expires in 12 days"),
                          const SizedBox(height: 32),
                          _buildSectionHeader("Recent Transactions"),
                          const SizedBox(height: 16),
                          _buildHistoryCard("First Term Tuition", "₹ 24,500",
                              "Received on 12 Jul"),
                          _buildHistoryCard("Admission Charges", "₹ 12,000",
                              "Received on 05 Jun"),
                          _buildHistoryCard("Annual Book Set", "₹ 3,500",
                              "Received on 01 Jun"),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageToggle() {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200)),
        child: Row(
          children: [
            Icon(Icons.translate, size: 14, color: _primaryOrange),
            const SizedBox(width: 4),
            Text(_selectedLanguage,
                style: TextStyle(
                    color: _primaryOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ],
        ),
      ),
    );
  }

  // --- UI BUILDING BLOCKS ---

  Widget _buildAppHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [_primaryOrange, _primaryOrange.withOpacity(0.8)]),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: _primaryOrange.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6))
              ],
            ),
            alignment: Alignment.center,
            child: const Text("A",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 22)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Aditya International",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        letterSpacing: -0.6,
                        color: Color(0xFF1A1A1A))),
                Row(
                  children: [
                    Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            color: Color(0xFF10B981), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text("Support Portal Active",
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          _buildLanguageToggle(),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [_primaryIndigo, const Color(0xFF6366F1)]),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 45),
      child: Column(
        children: [
          Row(children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.white, size: 16)),
            ),
            const SizedBox(width: 12),
            const Text("Fees Overview",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800)),
          ]),
          const SizedBox(height: 35),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Total Outstanding",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  const Text("₹ 26,700",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1)),
                  const SizedBox(height: 6),
                  const Text("For Academic Year 2025-26",
                      style: TextStyle(color: Colors.white54, fontSize: 11)),
                ]),
                const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white12,
                    child: Icon(Icons.account_balance_rounded,
                        color: Colors.white, size: 35)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDueCard(String title, String amount, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 20,
              offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: _textMain)),
                      const SizedBox(height: 4),
                      Row(children: [
                        Icon(Icons.timer_outlined, size: 12, color: _dueRose),
                        const SizedBox(width: 4),
                        Text(date,
                            style: TextStyle(
                                color: _dueRose,
                                fontSize: 12,
                                fontWeight: FontWeight.w700)),
                      ]),
                    ]),
              ),
              Text(amount,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: _textMain)),
            ],
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(height: 1, color: Color(0xFFF1F5F9))),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => _showPaymentOptions(title, amount),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryIndigo,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text("PROCEED TO PAY",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHistoryCard(String title, String amount, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black.withOpacity(0.03)),
      ),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: _paidGreen.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(Icons.verified_rounded, color: _paidGreen, size: 22)),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: _textMain)),
                Text(date,
                    style: TextStyle(
                        color: _textLight,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
              ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(amount,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color: _textMain)),
            Text("RECEIPT",
                style: TextStyle(
                    color: _primaryIndigo,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5)),
          ]),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) => Text(title.toUpperCase(),
      style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          color: _textLight,
          letterSpacing: 1.5));
}
