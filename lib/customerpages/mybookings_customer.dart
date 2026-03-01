import 'package:flutter/material.dart';

class MyBookingsScreen extends StatefulWidget {
  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock booking data with different statuses
  final List<Map<String, dynamic>> _allBookings = [
    {
      'id': 'BK-001',
      'serviceType': 'Electrical',
      'serviceIcon': Icons.electrical_services,
      'handyman': 'Juan Dela Cruz',
      'handymanImage': null,
      'handymanRating': 4.8,
      'date': 'Mar 2, 2026',
      'time': '2:00 PM',
      'status': 'Pending',
      'statusColor': Colors.orange,
      'statusText': 'Waiting for Acceptance',
      'amount': 850.00,
      'address': '123 Bonifacio St., Makati City',
      'description': 'Faulty electrical outlet in the kitchen',
      'paymentMethod': 'Cash',
      'timeline': [
        {
          'status': 'Request Sent',
          'time': 'Mar 1, 2026 10:30 AM',
          'completed': true,
        },
        {'status': 'Handyman Assigned', 'time': 'Pending', 'completed': false},
        {'status': 'In Progress', 'time': 'Pending', 'completed': false},
        {'status': 'Completed', 'time': 'Pending', 'completed': false},
      ],
    },
    {
      'id': 'BK-002',
      'serviceType': 'Plumbing',
      'serviceIcon': Icons.plumbing,
      'handyman': 'Pedro Santos',
      'handymanImage': null,
      'handymanRating': 4.5,
      'date': 'Mar 2, 2026',
      'time': '3:30 PM',
      'status': 'Accepted',
      'statusColor': Colors.blue,
      'statusText': 'Handyman Accepted',
      'amount': 650.00,
      'address': '456 Rizal Ave., Quezon City',
      'description': 'Leaking pipe under the sink',
      'paymentMethod': 'GCash',
      'timeline': [
        {
          'status': 'Request Sent',
          'time': 'Mar 1, 2026 11:45 AM',
          'completed': true,
        },
        {
          'status': 'Handyman Assigned',
          'time': 'Mar 1, 2026 2:30 PM',
          'completed': true,
        },
        {'status': 'In Progress', 'time': 'Pending', 'completed': false},
        {'status': 'Completed', 'time': 'Pending', 'completed': false},
      ],
    },
    {
      'id': 'BK-003',
      'serviceType': 'Carpentry',
      'serviceIcon': Icons.construction,
      'handyman': 'Jose Reyes',
      'handymanImage': null,
      'handymanRating': 4.9,
      'date': 'Mar 1, 2026',
      'time': '10:00 AM',
      'status': 'In Progress',
      'statusColor': Colors.green,
      'statusText': 'Service in Progress',
      'amount': 1200.00,
      'address': '789 Mabini St., Pasig City',
      'description': 'Repair broken cabinet door',
      'paymentMethod': 'Cash',
      'timeline': [
        {
          'status': 'Request Sent',
          'time': 'Feb 28, 2026 9:00 AM',
          'completed': true,
        },
        {
          'status': 'Handyman Assigned',
          'time': 'Feb 28, 2026 11:30 AM',
          'completed': true,
        },
        {
          'status': 'In Progress',
          'time': 'Mar 1, 2026 10:00 AM',
          'completed': true,
        },
        {'status': 'Completed', 'time': 'Pending', 'completed': false},
      ],
    },
    {
      'id': 'BK-004',
      'serviceType': 'Aircon Repair',
      'serviceIcon': Icons.ac_unit,
      'handyman': 'Maria Garcia',
      'handymanImage': null,
      'handymanRating': 4.7,
      'date': 'Feb 28, 2026',
      'time': '1:00 PM',
      'status': 'Completed',
      'statusColor': Colors.grey,
      'statusText': 'Service Completed',
      'amount': 1500.00,
      'address': '101 Roxas Blvd., Manila',
      'description': 'Aircon general cleaning',
      'paymentMethod': 'Credit Card',
      'rating': 4,
      'review': 'Good service, very professional',
      'timeline': [
        {
          'status': 'Request Sent',
          'time': 'Feb 27, 2026 3:00 PM',
          'completed': true,
        },
        {
          'status': 'Handyman Assigned',
          'time': 'Feb 27, 2026 5:30 PM',
          'completed': true,
        },
        {
          'status': 'In Progress',
          'time': 'Feb 28, 2026 1:00 PM',
          'completed': true,
        },
        {
          'status': 'Completed',
          'time': 'Feb 28, 2026 3:30 PM',
          'completed': true,
        },
      ],
    },
    {
      'id': 'BK-005',
      'serviceType': 'Electrical',
      'serviceIcon': Icons.electrical_services,
      'handyman': 'Juan Dela Cruz',
      'handymanImage': null,
      'handymanRating': 4.8,
      'date': 'Feb 27, 2026',
      'time': '4:00 PM',
      'status': 'Cancelled',
      'statusColor': Colors.red,
      'statusText': 'Booking Cancelled',
      'amount': 450.00,
      'address': '234 Paterno St., Mandaluyong',
      'description': 'Light fixture installation',
      'paymentMethod': 'Cash',
      'cancellationReason': 'Handyman unavailable',
      'timeline': [
        {
          'status': 'Request Sent',
          'time': 'Feb 26, 2026 2:00 PM',
          'completed': true,
        },
        {
          'status': 'Handyman Assigned',
          'time': 'Feb 26, 2026 4:30 PM',
          'completed': true,
        },
        {
          'status': 'Cancelled',
          'time': 'Feb 27, 2026 10:00 AM',
          'completed': true,
        },
      ],
    },
    {
      'id': 'BK-006',
      'serviceType': 'Plumbing',
      'serviceIcon': Icons.plumbing,
      'handyman': 'Pedro Santos',
      'handymanImage': null,
      'handymanRating': 4.5,
      'date': 'Mar 3, 2026',
      'time': '9:30 AM',
      'status': 'Pending',
      'statusColor': Colors.orange,
      'statusText': 'Waiting for Acceptance',
      'amount': 550.00,
      'address': '567 Shaw Blvd., Pasig City',
      'description': 'Faucet replacement',
      'paymentMethod': 'GCash',
      'timeline': [
        {
          'status': 'Request Sent',
          'time': 'Mar 2, 2026 8:00 AM',
          'completed': true,
        },
        {'status': 'Handyman Assigned', 'time': 'Pending', 'completed': false},
        {'status': 'In Progress', 'time': 'Pending', 'completed': false},
        {'status': 'Completed', 'time': 'Pending', 'completed': false},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _pendingBookings {
    return _allBookings.where((b) => b['status'] == 'Pending').toList();
  }

  List<Map<String, dynamic>> get _acceptedBookings {
    return _allBookings.where((b) => b['status'] == 'Accepted').toList();
  }

  List<Map<String, dynamic>> get _inProgressBookings {
    return _allBookings.where((b) => b['status'] == 'In Progress').toList();
  }

  List<Map<String, dynamic>> get _completedBookings {
    return _allBookings
        .where((b) => b['status'] == 'Completed' || b['status'] == 'Cancelled')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to dashboard customer screen
            Navigator.pushNamed(context, '/dashboard_customer');
          },
        ),
        title: Text(
          'My Bookings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1E5F4B),
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.white,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 12, color: Colors.white70),
          tabs: [
            Tab(text: 'Pending (${_pendingBookings.length})'),
            Tab(text: 'Accepted (${_acceptedBookings.length})'),
            Tab(text: 'In Progress (${_inProgressBookings.length})'),
            Tab(text: 'Completed (${_completedBookings.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingList(_pendingBookings, 'No pending bookings'),
          _buildBookingList(_acceptedBookings, 'No accepted bookings'),
          _buildBookingList(_inProgressBookings, 'No bookings in progress'),
          _buildCompletedList(_completedBookings),
        ],
      ),
    );
  }

  Widget _buildBookingList(
    List<Map<String, dynamic>> bookings,
    String emptyMessage,
  ) {
    if (bookings.isEmpty) {
      return _buildEmptyState(emptyMessage);
    }

    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return _buildBookingCard(booking);
      },
    );
  }

  Widget _buildCompletedList(List<Map<String, dynamic>> bookings) {
    if (bookings.isEmpty) {
      return _buildEmptyState('No completed bookings');
    }

    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return _buildCompletedBookingCard(booking);
      },
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    return GestureDetector(
      onTap: () {
        _showBookingDetails(booking);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            // Status Banner
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: booking['statusColor'].withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: booking['statusColor'],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    booking['statusText'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: booking['statusColor'],
                    ),
                  ),
                  Spacer(),
                  Text(
                    'ID: ${booking['id']}',
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            // Main Content
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Service and Handyman Row
                  Row(
                    children: [
                      // Service Icon
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFF2A7F6E).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          booking['serviceIcon'],
                          color: Color(0xFF2A7F6E),
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),

                      // Service Type and Handyman
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking['serviceType'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E5F4B),
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 14,
                                  color: Colors.grey[500],
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    booking['handyman'] ??
                                        'Finding handyman...',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Rating if available
                      if (booking['handymanRating'] != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 14),
                              SizedBox(width: 4),
                              Text(
                                booking['handymanRating'].toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Date, Time, and Amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Colors.grey[500],
                          ),
                          SizedBox(width: 4),
                          Text(
                            booking['date'],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey[500],
                          ),
                          SizedBox(width: 4),
                          Text(
                            booking['time'],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '₱${booking['amount'].toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E5F4B),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  // Description
                  Row(
                    children: [
                      Icon(
                        Icons.description,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          booking['description'],
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Action Buttons based on status
                  Row(children: _getActionButtons(booking)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedBookingCard(Map<String, dynamic> booking) {
    return GestureDetector(
      onTap: () {
        _showBookingDetails(booking);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            // Status Banner
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: booking['statusColor'].withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: booking['statusColor'],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    booking['statusText'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: booking['statusColor'],
                    ),
                  ),
                  Spacer(),
                  Text(
                    'ID: ${booking['id']}',
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            // Main Content
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Service and Handyman Row
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFF2A7F6E).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          booking['serviceIcon'],
                          color: Color(0xFF2A7F6E),
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking['serviceType'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E5F4B),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              booking['handyman'] ?? 'No handyman',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (booking['status'] == 'Completed' &&
                          booking['rating'] != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 14),
                              SizedBox(width: 4),
                              Text(
                                booking['rating'].toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 12),

                  // Date and Amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Colors.grey[500],
                          ),
                          SizedBox(width: 4),
                          Text(
                            booking['date'],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '₱${booking['amount'].toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E5F4B),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  // Action Buttons for completed/cancelled
                  Row(
                    children: [
                      if (booking['status'] == 'Completed')
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              _rateBooking(booking);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.amber,
                              side: BorderSide(color: Colors.amber),
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star, size: 16),
                                SizedBox(width: 4),
                                Text('Rate'),
                              ],
                            ),
                          ),
                        ),
                      if (booking['status'] == 'Completed') SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _bookAgain(booking);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2A7F6E),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Book Again'),
                        ),
                      ),
                      if (booking['status'] == 'Cancelled') SizedBox(width: 8),
                      if (booking['status'] == 'Cancelled')
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              _viewCancellationReason(booking);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: BorderSide(color: Colors.red),
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text('Reason'),
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
    );
  }

  List<Widget> _getActionButtons(Map<String, dynamic> booking) {
    switch (booking['status']) {
      case 'Pending':
        return [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                _cancelBooking(booking);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: BorderSide(color: Colors.red),
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Cancel'),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _contactSupport(booking);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2A7F6E),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Contact'),
            ),
          ),
        ];

      case 'Accepted':
        return [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                _rescheduleBooking(booking);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.orange,
                side: BorderSide(color: Colors.orange),
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Reschedule'),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _messageHandyman(booking);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2A7F6E),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Message'),
            ),
          ),
        ];

      case 'In Progress':
        return [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                _trackHandyman(booking);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green,
                side: BorderSide(color: Colors.green),
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 16),
                  SizedBox(width: 4),
                  Text('Track'),
                ],
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _contactHandyman(booking);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2A7F6E),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Contact'),
            ),
          ),
        ];

      default:
        return [];
    }
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF2A7F6E).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.event_busy, size: 60, color: Color(0xFF2A7F6E)),
          ),
          SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Your bookings will appear here',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to booking screen
              Navigator.pushNamed(context, '/booking_customer');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2A7F6E),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Book a Service'),
          ),
        ],
      ),
    );
  }

  void _showBookingDetails(Map<String, dynamic> booking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Header
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFF2A7F6E).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          booking['serviceIcon'],
                          color: Color(0xFF2A7F6E),
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking['serviceType'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E5F4B),
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: booking['statusColor'].withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                booking['statusText'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: booking['statusColor'],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        // Timeline
                        _buildTimeline(booking['timeline']),

                        SizedBox(height: 20),

                        // Handyman Info
                        if (booking['handyman'] != null)
                          _buildHandymanInfo(booking),

                        SizedBox(height: 20),

                        // Booking Details
                        _buildBookingDetailsCard(booking),

                        SizedBox(height: 20),

                        // Payment Info
                        _buildPaymentInfoCard(booking),

                        if (booking['status'] == 'Cancelled')
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.red.withOpacity(0.2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.cancel, color: Colors.red),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cancellation Reason',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          booking['cancellationReason'] ??
                                              'No reason provided',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        if (booking['status'] == 'Completed' &&
                            booking['rating'] != null)
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.amber.withOpacity(0.2),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your Review',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E5F4B),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      ...List.generate(5, (index) {
                                        return Icon(
                                          index < booking['rating']
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                          size: 20,
                                        );
                                      }),
                                      SizedBox(width: 8),
                                      Text(
                                        booking['rating'].toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (booking['review'] != null)
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        booking['review'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Bottom Action Button
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Color(0xFF2A7F6E),
                              side: BorderSide(color: Color(0xFF2A7F6E)),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text('Close'),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _contactSupport(booking);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF2A7F6E),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text('Need Help?'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTimeline(List<dynamic> timeline) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Booking Timeline',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          SizedBox(height: 16),
          ...List.generate(timeline.length, (index) {
            final step = timeline[index];
            final isLast = index == timeline.length - 1;
            return _buildTimelineStep(
              status: step['status'],
              time: step['time'],
              isCompleted: step['completed'],
              isLast: isLast,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTimelineStep({
    required String status,
    required String time,
    required bool isCompleted,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? Color(0xFF2A7F6E) : Colors.grey[300],
              ),
              child: isCompleted
                  ? Icon(Icons.check, color: Colors.white, size: 12)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? Color(0xFF2A7F6E) : Colors.grey[300],
              ),
          ],
        ),
        SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isCompleted
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isCompleted ? Color(0xFF1E5F4B) : Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHandymanInfo(Map<String, dynamic> booking) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Handyman',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFF2A7F6E).withOpacity(0.1),
                child: Icon(Icons.person, color: Color(0xFF2A7F6E), size: 30),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking['handyman'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          booking['handymanRating'].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.verified, color: Colors.blue, size: 16),
                        SizedBox(width: 4),
                        Text('Verified'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetailsCard(Map<String, dynamic> booking) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Booking Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          SizedBox(height: 12),
          _buildDetailRow(Icons.calendar_today, 'Date', booking['date']),
          _buildDetailRow(Icons.access_time, 'Time', booking['time']),
          _buildDetailRow(Icons.location_on, 'Location', booking['address']),
          _buildDetailRow(
            Icons.description,
            'Description',
            booking['description'],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfoCard(Map<String, dynamic> booking) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          SizedBox(height: 12),
          _buildDetailRow(Icons.payment, 'Method', booking['paymentMethod']),
          _buildDetailRow(
            Icons.attach_money,
            'Amount',
            '₱${booking['amount'].toStringAsFixed(2)}',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            child: Icon(icon, size: 18, color: Colors.grey[600]),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E5F4B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Action Methods
  void _cancelBooking(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel Booking'),
        content: Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Booking cancelled successfully'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  void _contactSupport(Map<String, dynamic> booking) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Connecting to support...'),
        backgroundColor: Color(0xFF2A7F6E),
      ),
    );
  }

  void _rescheduleBooking(Map<String, dynamic> booking) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reschedule feature coming soon!'),
        backgroundColor: Color(0xFF2A7F6E),
      ),
    );
  }

  void _messageHandyman(Map<String, dynamic> booking) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Messaging feature coming soon!'),
        backgroundColor: Color(0xFF2A7F6E),
      ),
    );
  }

  void _trackHandyman(Map<String, dynamic> booking) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tracking feature coming soon!'),
        backgroundColor: Color(0xFF2A7F6E),
      ),
    );
  }

  void _contactHandyman(Map<String, dynamic> booking) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calling handyman...'),
        backgroundColor: Color(0xFF2A7F6E),
      ),
    );
  }

  void _bookAgain(Map<String, dynamic> booking) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Redirecting to booking...'),
        backgroundColor: Color(0xFF2A7F6E),
      ),
    );
    // Navigate to booking screen
    // Navigator.pushNamed(context, '/booking_customer', arguments: {'service': booking['serviceType']});
  }

  void _rateBooking(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rate Your Experience'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('How was your service with ${booking['handyman']}?'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < 4 ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Thank you for your rating!'),
                        backgroundColor: Color(0xFF2A7F6E),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _viewCancellationReason(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancellation Reason'),
        content: Text(booking['cancellationReason'] ?? 'No reason provided'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
