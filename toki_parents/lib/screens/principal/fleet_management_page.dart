import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class FleetManagementPage extends StatefulWidget {
  const FleetManagementPage({Key? key}) : super(key: key);

  @override
  _FleetManagementPageState createState() => _FleetManagementPageState();
}

class _FleetManagementPageState extends State<FleetManagementPage> {
  int _currentIndex = 3;
  bool _isTelugu = false;
  String _selectedFilter = 'All Vehicles';
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _allVehicles = [
    {
      'vehicleNumber': 'AP-07-AB-1234',
      'vehicleType': 'School Bus',
      'driver': 'Mr. Rajesh Kumar',
      'capacity': 40,
      'status': 'Active',
      'route': 'Route A - City Center',
      'currentLocation': 'Near Main Gate',
      'nextPickup': '8:30 AM',
    },
    {
      'vehicleNumber': 'AP-07-CD-5678',
      'vehicleType': 'Mini Bus',
      'driver': 'Mr. Suresh Reddy',
      'capacity': 25,
      'status': 'On Trip',
      'route': 'Route B - Suburbs',
      'currentLocation': 'En route to school',
      'nextPickup': '9:00 AM',
    },
    {
      'vehicleNumber': 'AP-07-EF-9012',
      'vehicleType': 'School Bus',
      'driver': 'Mrs. Anitha Sharma',
      'capacity': 35,
      'status': 'Maintenance',
      'route': 'Route C - Downtown',
      'currentLocation': 'Service Center',
      'nextPickup': 'Not Available',
    },
    {
      'vehicleNumber': 'AP-07-GH-3456',
      'vehicleType': 'Van',
      'driver': 'Mr. Ravi Teja',
      'capacity': 15,
      'status': 'Active',
      'route': 'Route D - Staff Transport',
      'currentLocation': 'Staff Quarters',
      'nextPickup': '8:15 AM',
    },
  ];

  final Map<String, String> _teluguTranslations = {
    'Fleet Management': 'ఫ్లీట్ నిర్వహణ',
    'All Vehicles Overview': 'అన్ని వాహనాల అవలోకనం',
    'Vehicles': 'వాహనాలు',
    'Active': 'చురుకుగా',
    'On Trip': 'ప్రయాణంలో',
    'Maintenance': 'పరిరక్షణ',
    'Driver': 'డ్రైవర్',
    'Capacity': 'సామర్థ్యం',
    'Route': 'మార్గం',
    'Current Location': 'ప్రస్తుత స్థానం',
    'Next Pickup': 'తదుపరి ఎత్తుకోవడం',
    'All Vehicles': 'అన్ని వాహనాలు',
    'School Bus': 'స్కూల్ బస్సు',
    'Mini Bus': 'మినీ బస్సు',
    'Van': 'వ్యాన్',
    'Search': 'వెతకండి',
    'View Details': 'వివరాలు చూడండి',
  };

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, PrincipalRoutes.home);
        break;
      case 1:
        Navigator.pushNamed(context, PrincipalRoutes.search);
        break;
      case 2:
        Navigator.pushNamed(context, PrincipalRoutes.activity);
        break;
      case 3:
        Navigator.pushNamed(
          context,
          PrincipalRoutes.morePage,
          arguments: {'section': null},
        );
        break;
    }
  }

  List<Map<String, dynamic>> get _filteredVehicles {
    if (_selectedFilter == 'All Vehicles') {
      return _allVehicles;
    } else {
      return _allVehicles.where((v) => v['vehicleType'] == _selectedFilter).toList();
    }
  }

  void _openVehicleDetails(Map<String, dynamic> vehicleData) {
    // Navigate to vehicle details page
  }

  String _getText(String englishText) {
    if (_isTelugu && _teluguTranslations.containsKey(englishText)) {
      return _teluguTranslations[englishText]!;
    }
    return englishText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed AppBar
            _buildAppBar(),

            // Scrollable Content (including hero section)
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  setState(() {});
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // Hero Section - Now Scrollable
                      _buildHeader(),

                      // Filter Bar - Now Scrollable
                      _buildFilterBar(),

                      // Vehicle List
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildVehicleList(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xff4E7CF9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                "A",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Aditya International School",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  _getText('Fleet Management'),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                _isTelugu ? "English" : "తెలుగు",
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff34A853),
            Color(0xff0D652D),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.directions_bus, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _getText('All Vehicles Overview'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard('4', _getText('Vehicles')),
              const SizedBox(width: 12),
              _buildStatCard('3', _getText('Active')),
              const SizedBox(width: 12),
              _buildStatCard('115', _getText('Capacity')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _getText('All Vehicles'),
                  _getText('School Bus'),
                  _getText('Mini Bus'),
                  _getText('Van')
                ].map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: _selectedFilter == filter,
                      selectedColor: const Color(0xff34A853),
                      labelStyle: TextStyle(
                        color: _selectedFilter == filter ? Colors.white : Colors.black,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xff34A853)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleList() {
    return Column(
      children: List.generate(_filteredVehicles.length, (index) {
        final vehicleData = _filteredVehicles[index];
        return _buildVehicleCard(vehicleData);
      }),
    );
  }

  Widget _buildVehicleCard(Map<String, dynamic> vehicleData) {
    Color statusColor;
    switch (vehicleData['status']) {
      case 'Active':
        statusColor = Colors.green;
        break;
      case 'On Trip':
        statusColor = Colors.orange;
        break;
      case 'Maintenance':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => _openVehicleDetails(vehicleData),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xff34A853).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.directions_bus,
                      color: Color(0xff34A853),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicleData['vehicleNumber'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${_getText('Driver')}: ${vehicleData['driver']}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getText(vehicleData['status']),
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoItem(Icons.people_outline, '${vehicleData['capacity']} ${_getText('Capacity')}'),
                  _buildInfoItem(Icons.route, vehicleData['route']),
                  _buildInfoItem(Icons.location_on_outlined, vehicleData['currentLocation']),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xffF5F7FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${_getText('Next Pickup')}: ${vehicleData['nextPickup']}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _openVehicleDetails(vehicleData),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _getText('View Details'),
                        style: const TextStyle(color: Color(0xff34A853)),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward, size: 16, color: Color(0xff34A853)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xff34A853),
        unselectedItemColor: Colors.grey,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}