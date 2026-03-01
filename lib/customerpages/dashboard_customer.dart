import 'package:flutter/material.dart';

class CustomerDashboard extends StatefulWidget {
  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  int _selectedIndex = 0;
  
  // Mock data - In production, this would come from your backend
  final String _customerName = "Juan";
  final int _activeBookings = 2;
  final int _completedBookings = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              radius: 16,
              child: Icon(Icons.handyman, color: Colors.white, size: 16),
            ),
            SizedBox(width: 8),
            Text(
              'HandyLink PH',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF1E5F4B),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              // Show notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () {
              // Show profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, $_customerName!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E5F4B),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'What home repair do you need today?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Request Service Card (Main CTA)
              GestureDetector(
                onTap: () {
                  _showServiceCategories();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF2A7F6E), Color(0xFF1E5F4B)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF2A7F6E).withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REQUEST SERVICE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Book a verified handyman now',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24),

              // Divider
              Divider(
                color: Colors.grey[300],
                thickness: 1,
                height: 32,
              ),

              // Main Menu Options
              Text(
                'Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E5F4B),
                ),
              ),
              SizedBox(height: 16),

              // My Bookings Card
              _buildMenuCard(
                title: 'My Bookings',
                description: 'View your service requests and history',
                icon: Icons.calendar_today,
                badgeCount: _activeBookings,
                badgeColor: Colors.orange,
                onTap: () {
                  Navigator.pushNamed(context, '/my-bookings');
                },
              ),

              SizedBox(height: 12),

              // Support Card
              _buildMenuCard(
                title: 'Support',
                description: 'Get help and contact customer service',
                icon: Icons.headset_mic,
                badgeCount: null,
                badgeColor: null,
                onTap: () {
                  _showSupportOptions();
                },
              ),

              SizedBox(height: 12),

              // Additional Menu Items (Optional enhancements)
              _buildMenuCard(
                title: 'Favorite Handymen',
                description: 'View your saved handymen',
                icon: Icons.favorite,
                badgeCount: 3,
                badgeColor: Colors.red,
                onTap: () {
                  _showComingSoon('Favorite Handymen');
                },
              ),

              SizedBox(height: 20),

              // Promo Banner (Optional)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF2A7F6E).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xFF2A7F6E).withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_offer,
                      color: Color(0xFF2A7F6E),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'First Service Discount!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E5F4B),
                            ),
                          ),
                          Text(
                            'Get 20% off on your first booking',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _showComingSoon('Promo Details');
                      },
                      child: Text(
                        'Claim',
                        style: TextStyle(
                          color: Color(0xFF2A7F6E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          
          // Handle navigation based on index
          switch (index) {
            case 0:
              // Already on dashboard
              break;
            case 1:
              Navigator.pushNamed(context, '/my-bookings');
              break;
            case 2:
              _showSupportOptions();
              break;
            case 3:
              _showComingSoon('Profile');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF2A7F6E),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.headset_mic),
            label: 'Support',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 16),
          SizedBox(width: 4),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required String title,
    required String description,
    required IconData icon,
    int? badgeCount,
    Color? badgeColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF2A7F6E).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Color(0xFF2A7F6E), size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E5F4B),
                          ),
                        ),
                      ),
                      if (badgeCount != null && badgeCount > 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: badgeColor ?? Colors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            badgeCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  void _showServiceCategories() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Service',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E5F4B),
                ),
              ),
              SizedBox(height: 16),
              _buildServiceItem(
                icon: Icons.plumbing,
                title: 'Plumbing',
                description: 'Faucets, pipes, water heater',
              ),
              _buildServiceItem(
                icon: Icons.electrical_services,
                title: 'Electrical',
                description: 'Wiring, outlets, fixtures',
              ),
              _buildServiceItem(
                icon: Icons.construction,
                title: 'Carpentry',
                description: 'Furniture repair, installations',
              ),
              _buildServiceItem(
                icon: Icons.ac_unit,
                title: 'Aircon Repair',
                description: 'Cleaning, repair, maintenance',
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/book-service');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2A7F6E),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Book Custom Service'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildServiceItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFF2A7F6E).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Color(0xFF2A7F6E)),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E5F4B),
        ),
      ),
      subtitle: Text(description),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/book-service', arguments: {'service': title});
      },
    );
  }

  void _showSupportOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Customer Support',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E5F4B),
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.chat, color: Color(0xFF2A7F6E)),
                title: Text('Live Chat'),
                subtitle: Text('Chat with our support team'),
                onTap: () {
                  Navigator.pop(context);
                  _showComingSoon('Live Chat');
                },
              ),
              ListTile(
                leading: Icon(Icons.phone, color: Color(0xFF2A7F6E)),
                title: Text('Call Us'),
                subtitle: Text('+63 912 345 6789'),
                onTap: () {
                  Navigator.pop(context);
                  _showComingSoon('Phone Support');
                },
              ),
              ListTile(
                leading: Icon(Icons.email, color: Color(0xFF2A7F6E)),
                title: Text('Email'),
                subtitle: Text('support@handylink.ph'),
                onTap: () {
                  Navigator.pop(context);
                  _showComingSoon('Email Support');
                },
              ),
              ListTile(
                leading: Icon(Icons.help_outline, color: Color(0xFF2A7F6E)),
                title: Text('FAQ'),
                subtitle: Text('Frequently asked questions'),
                onTap: () {
                  Navigator.pop(context);
                  _showComingSoon('FAQ');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature coming soon!'),
        backgroundColor: Color(0xFF2A7F6E),
        duration: Duration(seconds: 2),
      ),
    );
  }
}