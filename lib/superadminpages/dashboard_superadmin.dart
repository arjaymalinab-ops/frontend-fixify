import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  
  // Mock data - In production, this would come from your backend
  final int _pendingApprovals = 2;
  final int _totalHandymen = 3;
  final int _totalBookings = 3;
  final int _completedBookings = 1;

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
              'HandyLink PH Admin',
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
                      'Welcome back, Admin!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E5F4B),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Here\'s what\'s happening with your platform today',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Stats Grid
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _buildStatCard(
                    title: 'Pending Approvals',
                    value: _pendingApprovals.toString(),
                    icon: Icons.pending_actions,
                    color: Colors.orange,
                    bgColor: Colors.orange.withOpacity(0.1),
                  ),
                  _buildStatCard(
                    title: 'Total Handymen',
                    value: _totalHandymen.toString(),
                    icon: Icons.handyman,
                    color: Color(0xFF2A7F6E),
                    bgColor: Color(0xFF2A7F6E).withOpacity(0.1),
                  ),
                  _buildStatCard(
                    title: 'Total Bookings',
                    value: _totalBookings.toString(),
                    icon: Icons.calendar_today,
                    color: Colors.blue,
                    bgColor: Colors.blue.withOpacity(0.1),
                  ),
                  _buildStatCard(
                    title: 'Completed',
                    value: _completedBookings.toString(),
                    icon: Icons.check_circle,
                    color: Colors.green,
                    bgColor: Colors.green.withOpacity(0.1),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Divider
              Divider(
                color: Colors.grey[300],
                thickness: 1,
                height: 32,
              ),

              // Management Sections
              Text(
                'Management',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E5F4B),
                ),
              ),
              SizedBox(height: 16),

              // Handyman Approvals Card
              _buildManagementCard(
                title: 'Handyman Approvals',
                description: 'Review and approve handyman applications',
                icon: Icons.verified_user,
                badgeCount: _pendingApprovals,
                badgeColor: Colors.orange,
                onTap: () {
                  // Navigate to handyman approvals page
                  _showComingSoon('Handyman Approvals');
                },
              ),

              SizedBox(height: 12),

              // Analytics Dashboard Card
              _buildManagementCard(
                title: 'Analytics Dashboard',
                description: 'View platform insights and statistics',
                icon: Icons.analytics,
                badgeCount: null,
                badgeColor: null,
                onTap: () {
                  // Navigate to analytics page
                  _showComingSoon('Analytics Dashboard');
                },
              ),

              SizedBox(height: 12),

              // Additional Management Cards (extending the design)
              _buildManagementCard(
                title: 'User Management',
                description: 'Manage customers and handymen accounts',
                icon: Icons.people,
                badgeCount: null,
                badgeColor: null,
                onTap: () {
                  _showComingSoon('User Management');
                },
              ),

              SizedBox(height: 12),

              _buildManagementCard(
                title: 'Booking Overview',
                description: 'View and manage all platform bookings',
                icon: Icons.assignment,
                badgeCount: _totalBookings,
                badgeColor: Colors.blue,
                onTap: () {
                  _showComingSoon('Booking Overview');
                },
              ),

              SizedBox(height: 20),
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
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF2A7F6E),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions),
            label: 'Approvals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagementCard({
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