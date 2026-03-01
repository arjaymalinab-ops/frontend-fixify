import 'package:flutter/material.dart';

class HandymanDashboard extends StatefulWidget {
  @override
  _HandymanDashboardState createState() => _HandymanDashboardState();
}

class _HandymanDashboardState extends State<HandymanDashboard> {
  int _selectedIndex = 0;
  
  // Mock data - In production, this would come from your backend
  final String _firstName = "Juan";
  final String _lastName = "Santos";
  final double _rating = 4.8;
  final int _totalJobs = 156;
  final int _pendingRequests = 3;
  final bool _isPremium = true;
  final String _currentJobStatus = "Ongoing";
  final double _earningsToday = 1250.00;
  final double _earningsWeek = 8750.00;
  final double _earningsMonth = 35250.00;

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
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showMenuOptions();
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
              // Profile Header Section
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Profile Avatar with initial
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF2A7F6E), Color(0xFF1E5F4B)],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          _getInitials(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    // Name and Rating
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '$_firstName $_lastName',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E5F4B),
                                ),
                              ),
                              SizedBox(width: 8),
                              if (_isPremium)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.star, color: Colors.white, size: 12),
                                      SizedBox(width: 4),
                                      Text(
                                        'Premium',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 18),
                              SizedBox(width: 4),
                              Text(
                                '$_rating',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[800],
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '($_totalJobs jobs)',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Rating',
                      value: '$_rating',
                      icon: Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Total Jobs',
                      value: '$_totalJobs',
                      icon: Icons.work,
                      color: Color(0xFF2A7F6E),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Pending',
                      value: '$_pendingRequests',
                      icon: Icons.pending_actions,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Main Menu Options
              Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E5F4B),
                ),
              ),
              SizedBox(height: 16),

              // Booking Requests Card
              _buildMenuCard(
                title: 'Booking Requests',
                description: 'View and accept new service requests',
                icon: Icons.calendar_today,
                badgeCount: _pendingRequests,
                badgeColor: Colors.orange,
                onTap: () {
                  Navigator.pushNamed(context, '/booking-requests');
                },
              ),

              SizedBox(height: 12),

              // Current Job Card
              _buildMenuCard(
                title: 'Current Job',
                description: 'Manage your active job',
                icon: Icons.construction,
                badgeCount: null,
                badgeColor: null,
                trailing: _buildStatusChip(_currentJobStatus),
                onTap: () {
                  Navigator.pushNamed(context, '/current-job');
                },
              ),

              SizedBox(height: 12),

              // Earnings Summary Card
              _buildMenuCard(
                title: 'Earnings Summary',
                description: 'View your earnings and job history',
                icon: Icons.monetization_on,
                badgeCount: null,
                badgeColor: null,
                onTap: () {
                  _showEarningsSummary();
                },
              ),

              SizedBox(height: 12),

              // Subscription Status Card
              _buildMenuCard(
                title: 'Subscription Status',
                description: _isPremium ? 'Active - Premium Benefits' : 'Free Tier',
                icon: Icons.star,
                badgeCount: null,
                badgeColor: null,
                trailing: _isPremium 
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'ACTIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'FREE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                onTap: () {
                  _showSubscriptionDetails();
                },
              ),

              SizedBox(height: 20),

              // Ratings Overview Section
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ratings Overview',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E5F4B),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        // Rating Circle
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber.withOpacity(0.1),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$_rating',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber[800],
                                    ),
                                  ),
                                  Text(
                                    'out of 5',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              _buildRatingBar(5, 0.9),
                              _buildRatingBar(4, 0.7),
                              _buildRatingBar(3, 0.3),
                              _buildRatingBar(2, 0.15),
                              _buildRatingBar(1, 0.1),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildRatingStat('Average Rating', '$_rating', Colors.amber),
                        _buildRatingStat('Total Jobs', '$_totalJobs', Color(0xFF2A7F6E)),
                        _buildRatingStat('Completion', '98%', Colors.green),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Quick Actions
              Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E5F4B),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildQuickAction(
                      icon: Icons.chat,
                      label: 'Messages',
                      count: 2,
                      onTap: () {
                        _showComingSoon('Messages');
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickAction(
                      icon: Icons.schedule,
                      label: 'Schedule',
                      count: null,
                      onTap: () {
                        _showComingSoon('Schedule');
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickAction(
                      icon: Icons.help,
                      label: 'Support',
                      count: null,
                      onTap: () {
                        _showComingSoon('Support');
                      },
                    ),
                  ),
                ],
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
              Navigator.pushNamed(context, '/booking-requests');
              break;
            case 2:
              Navigator.pushNamed(context, '/earnings');
              break;
            case 3:
              Navigator.pushNamed(context, '/profile');
              break;
          }
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
            icon: Icon(Icons.calendar_today),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
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
    Widget? trailing,
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
                      if (trailing != null) trailing,
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

  Widget _buildRatingBar(int stars, double percentage) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '$stars ★',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percentage,
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 30),
        ],
      ),
    );
  }

  Widget _buildRatingStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    int? count,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Icon(icon, color: Color(0xFF2A7F6E), size: 24),
                SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            if (count != null && count > 0)
              Positioned(
                top: -4,
                right: 20,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'ongoing':
        color = Colors.blue;
        break;
      case 'completed':
        color = Colors.green;
        break;
      case 'pending':
        color = Colors.orange;
        break;
      default:
        color = Colors.grey;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getInitials() {
    return '${_firstName[0]}${_lastName[0]}';
  }

  void _showEarningsSummary() {
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
                'Earnings Summary',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E5F4B),
                ),
              ),
              SizedBox(height: 20),
              _buildEarningRow('Today', _earningsToday),
              _buildEarningRow('This Week', _earningsWeek),
              _buildEarningRow('This Month', _earningsMonth),
              Divider(height: 30),
              _buildEarningRow('Total', _earningsMonth, isTotal: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/earnings');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2A7F6E),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('View Full History'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEarningRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Color(0xFF1E5F4B) : Colors.grey[700],
            ),
          ),
          Text(
            '₱${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? Color(0xFF2A7F6E) : Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  void _showSubscriptionDetails() {
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
                'Premium Subscription',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E5F4B),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Get priority booking and more benefits',
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              _buildBenefitItem(Icons.star, 'Priority booking visibility'),
              _buildBenefitItem(Icons.trending_up, 'Featured in search results'),
              _buildBenefitItem(Icons.support_agent, 'Priority support'),
              _buildBenefitItem(Icons.monetization_on, 'Lower platform fees'),
              SizedBox(height: 20),
              if (_isPremium)
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Your Premium subscription is active',
                          style: TextStyle(color: Colors.green[700]),
                        ),
                      ),
                    ],
                  ),
                )
              else
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showComingSoon('Premium Subscription');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Upgrade to Premium - ₱199/mo'),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBenefitItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF2A7F6E), size: 20),
          SizedBox(width: 12),
          Text(text, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  void _showMenuOptions() {
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
              ListTile(
                leading: Icon(Icons.person, color: Color(0xFF2A7F6E)),
                title: Text('Edit Profile'),
                onTap: () {
                  Navigator.pop(context);
                  _showComingSoon('Edit Profile');
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Color(0xFF2A7F6E)),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  _showComingSoon('Settings');
                },
              ),
              ListTile(
                leading: Icon(Icons.help, color: Color(0xFF2A7F6E)),
                title: Text('Help & Support'),
                onTap: () {
                  Navigator.pop(context);
                  _showComingSoon('Help & Support');
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text('Logout', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _showLogoutDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
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