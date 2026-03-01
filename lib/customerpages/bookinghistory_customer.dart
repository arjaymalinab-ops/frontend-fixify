import 'package:flutter/material.dart';

class BookingHistoryScreen extends StatefulWidget {
  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock booking data
  final List<Map<String, dynamic>> _allBookings = [
    {
      'id': 'BK-001',
      'serviceType': 'Electrical',
      'serviceIcon': Icons.electrical_services,
      'handyman': 'Juan Dela Cruz',
      'date': 'Mar 1, 2026',
      'time': '2:00 PM',
      'status': 'Completed',
      'statusColor': Colors.green,
      'amount': 850.00,
      'address': '123 Bonifacio St., Makati City',
      'description': 'Faulty electrical outlet installation in kitchen',
      'rating': 4.5,
      'paymentMethod': 'Cash',
    },
    {
      'id': 'BK-002',
      'serviceType': 'Plumbing',
      'serviceIcon': Icons.plumbing,
      'handyman': 'Pedro Santos',
      'date': 'Feb 28, 2026',
      'time': '10:30 AM',
      'status': 'Completed',
      'statusColor': Colors.green,
      'amount': 650.00,
      'address': '456 Rizal Ave., Quezon City',
      'description': 'Leaking pipe repair under kitchen sink',
      'rating': 5.0,
      'paymentMethod': 'GCash',
    },
    {
      'id': 'BK-003',
      'serviceType': 'Carpentry',
      'serviceIcon': Icons.construction,
      'handyman': 'Jose Reyes',
      'date': 'Feb 25, 2026',
      'time': '11:00 AM',
      'status': 'Cancelled',
      'statusColor': Colors.red,
      'amount': 1200.00,
      'address': '789 Mabini St., Pasig City',
      'description': 'Cabinet repair and installation',
      'rating': null,
      'paymentMethod': 'Cash',
      'cancellationReason': 'Handyman unavailable',
    },
    {
      'id': 'BK-004',
      'serviceType': 'Aircon Repair',
      'serviceIcon': Icons.ac_unit,
      'handyman': 'Maria Garcia',
      'date': 'Feb 20, 2026',
      'time': '3:30 PM',
      'status': 'Completed',
      'statusColor': Colors.green,
      'amount': 1500.00,
      'address': '101 Roxas Blvd., Manila',
      'description': 'Aircon general cleaning and maintenance',
      'rating': 4.0,
      'paymentMethod': 'Credit Card',
    },
    {
      'id': 'BK-005',
      'serviceType': 'Electrical',
      'serviceIcon': Icons.electrical_services,
      'handyman': 'Juan Dela Cruz',
      'date': 'Feb 15, 2026',
      'time': '9:00 AM',
      'status': 'Completed',
      'statusColor': Colors.green,
      'amount': 950.00,
      'address': '234 Paterno St., Mandaluyong',
      'description': 'Light fixture installation',
      'rating': 4.5,
      'paymentMethod': 'Cash',
    },
    {
      'id': 'BK-006',
      'serviceType': 'Plumbing',
      'serviceIcon': Icons.plumbing,
      'handyman': 'Pedro Santos',
      'date': 'Feb 10, 2026',
      'time': '1:00 PM',
      'status': 'In Progress',
      'statusColor': Colors.orange,
      'amount': 450.00,
      'address': '567 Shaw Blvd., Pasig City',
      'description': 'Faucet replacement',
      'rating': null,
      'paymentMethod': 'GCash',
    },
    {
      'id': 'BK-007',
      'serviceType': 'Carpentry',
      'serviceIcon': Icons.construction,
      'handyman': 'Jose Reyes',
      'date': 'Feb 5, 2026',
      'time': '4:00 PM',
      'status': 'Completed',
      'statusColor': Colors.green,
      'amount': 1800.00,
      'address': '890 EDSA, Quezon City',
      'description': 'Custom shelf installation',
      'rating': 5.0,
      'paymentMethod': 'Cash',
    },
    {
      'id': 'BK-008',
      'serviceType': 'Aircon Repair',
      'serviceIcon': Icons.ac_unit,
      'handyman': 'Maria Garcia',
      'date': 'Feb 1, 2026',
      'time': '10:00 AM',
      'status': 'Completed',
      'statusColor': Colors.green,
      'amount': 1200.00,
      'address': '123 Banawe St., Quezon City',
      'description': 'Aircon compressor repair',
      'rating': 4.0,
      'paymentMethod': 'Credit Card',
    },
    {
      'id': 'BK-009',
      'serviceType': 'Electrical',
      'serviceIcon': Icons.electrical_services,
      'handyman': 'Juan Dela Cruz',
      'date': 'Jan 28, 2026',
      'time': '2:30 PM',
      'status': 'Completed',
      'statusColor': Colors.green,
      'amount': 750.00,
      'address': '456 Taft Ave., Manila',
      'description': 'Circuit breaker replacement',
      'rating': 4.0,
      'paymentMethod': 'Cash',
    },
    {
      'id': 'BK-010',
      'serviceType': 'Plumbing',
      'serviceIcon': Icons.plumbing,
      'handyman': 'Pedro Santos',
      'date': 'Jan 25, 2026',
      'time': '11:30 AM',
      'status': 'Cancelled',
      'statusColor': Colors.red,
      'amount': 550.00,
      'address': '789 Katipunan Ave., Quezon City',
      'description': 'Water heater installation',
      'rating': null,
      'paymentMethod': 'GCash',
      'cancellationReason': 'Customer cancelled',
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

  List<Map<String, dynamic>> get _completedBookings {
    return _allBookings.where((b) => b['status'] == 'Completed').toList();
  }

  List<Map<String, dynamic>> get _inProgressBookings {
    return _allBookings.where((b) => b['status'] == 'In Progress').toList();
  }

  List<Map<String, dynamic>> get _cancelledBookings {
    return _allBookings.where((b) => b['status'] == 'Cancelled').toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking History',
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
            fontSize: 13,
            color: Colors.white,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 13, color: Colors.white70),
          tabs: [
            Tab(text: 'All (${_allBookings.length})'),
            Tab(text: 'Completed (${_completedBookings.length})'),
            Tab(text: 'In Progress (${_inProgressBookings.length})'),
            Tab(text: 'Cancelled (${_cancelledBookings.length})'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterOptions();
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingList(_allBookings),
          _buildBookingList(_completedBookings),
          _buildBookingList(_inProgressBookings),
          _buildBookingList(_cancelledBookings),
        ],
      ),
    );
  }

  Widget _buildBookingList(List<Map<String, dynamic>> bookings) {
    if (bookings.isEmpty) {
      return _buildEmptyState();
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
            // Top section with service type and status
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
              ),
              child: Row(
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
                        Text(
                          booking['handyman'],
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Status Badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: booking['statusColor'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: booking['statusColor'].withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      booking['status'],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: booking['statusColor'],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Middle section with booking details
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Date and Time
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                      SizedBox(width: 8),
                      Text(
                        booking['date'],
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                      SizedBox(width: 8),
                      Text(
                        booking['time'],
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // Address
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          booking['address'],
                          style: TextStyle(color: Colors.grey[700]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // Amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount:',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                      Text(
                        '₱${booking['amount'].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E5F4B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Bottom section with rating/action buttons
            if (booking['status'] == 'Completed')
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Rating stars
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          double rating = booking['rating'] ?? 0;
                          return Icon(
                            index < rating.floor()
                                ? Icons.star
                                : (index < rating
                                      ? Icons.star_half
                                      : Icons.star_border),
                            color: Colors.amber,
                            size: 18,
                          );
                        }),
                        SizedBox(width: 8),
                        Text(
                          booking['rating'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),

                    // Book again button
                    TextButton(
                      onPressed: () {
                        _bookAgain(booking);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xFF2A7F6E),
                      ),
                      child: Text('Book Again'),
                    ),
                  ],
                ),
              ),

            if (booking['status'] == 'Cancelled')
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.05),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: Colors.red),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Cancelled: ${booking['cancellationReason'] ?? 'No reason provided'}',
                        style: TextStyle(fontSize: 12, color: Colors.red[700]),
                      ),
                    ),
                  ],
                ),
              ),

            if (booking['status'] == 'In Progress')
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.05),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Service in progress',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange[700],
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        _trackBooking(booking);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.orange,
                      ),
                      child: Text('Track'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
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
            child: Icon(Icons.history, size: 60, color: Color(0xFF2A7F6E)),
          ),
          SizedBox(height: 20),
          Text(
            'No Bookings Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Your booking history will appear here',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
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
                  // Handle bar
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

                  // Header with status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Booking Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E5F4B),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: booking['statusColor'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: booking['statusColor'].withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          booking['status'],
                          style: TextStyle(
                            color: booking['statusColor'],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        // Service Info Card
                        _buildDetailCard(
                          title: 'Service Information',
                          children: [
                            _buildDetailRow(
                              icon: booking['serviceIcon'],
                              label: 'Service Type',
                              value: booking['serviceType'],
                            ),
                            _buildDetailRow(
                              icon: Icons.person,
                              label: 'Handyman',
                              value: booking['handyman'],
                            ),
                            _buildDetailRow(
                              icon: Icons.description,
                              label: 'Description',
                              value: booking['description'],
                            ),
                          ],
                        ),

                        SizedBox(height: 16),

                        // Schedule Card
                        _buildDetailCard(
                          title: 'Schedule',
                          children: [
                            _buildDetailRow(
                              icon: Icons.calendar_today,
                              label: 'Date',
                              value: booking['date'],
                            ),
                            _buildDetailRow(
                              icon: Icons.access_time,
                              label: 'Time',
                              value: booking['time'],
                            ),
                          ],
                        ),

                        SizedBox(height: 16),

                        // Location Card
                        _buildDetailCard(
                          title: 'Location',
                          children: [
                            _buildDetailRow(
                              icon: Icons.location_on,
                              label: 'Address',
                              value: booking['address'],
                            ),
                          ],
                        ),

                        SizedBox(height: 16),

                        // Payment Card
                        _buildDetailCard(
                          title: 'Payment Information',
                          children: [
                            _buildDetailRow(
                              icon: Icons.payment,
                              label: 'Payment Method',
                              value: booking['paymentMethod'],
                            ),
                            _buildDetailRow(
                              icon: Icons.attach_money,
                              label: 'Total Amount',
                              value: '₱${booking['amount'].toStringAsFixed(2)}',
                              valueStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E5F4B),
                              ),
                            ),
                          ],
                        ),

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

                        if (booking['status'] == 'Completed')
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: _buildDetailCard(
                              title: 'Your Rating',
                              children: [
                                Row(
                                  children: [
                                    ...List.generate(5, (index) {
                                      double rating = booking['rating'] ?? 0;
                                      return Icon(
                                        index < rating.floor()
                                            ? Icons.star
                                            : (index < rating
                                                  ? Icons.star_half
                                                  : Icons.star_border),
                                        color: Colors.amber,
                                        size: 24,
                                      );
                                    }),
                                    SizedBox(width: 12),
                                    Text(
                                      booking['rating'].toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
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

                  // Action buttons
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        if (booking['status'] == 'Completed')
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _bookAgain(booking);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF2A7F6E),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text('Book Again'),
                            ),
                          ),
                        if (booking['status'] == 'Completed')
                          SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _downloadReceipt(booking);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Color(0xFF2A7F6E),
                              side: BorderSide(color: Color(0xFF2A7F6E)),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text('Download Receipt'),
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

  Widget _buildDetailCard({
    required String title,
    required List<Widget> children,
  }) {
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
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    TextStyle? valueStyle,
  }) {
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
                  style:
                      valueStyle ??
                      TextStyle(
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

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Search Bookings'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Search by service, handyman, or ID',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Search feature coming soon!'),
                  backgroundColor: Color(0xFF2A7F6E),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2A7F6E),
              foregroundColor: Colors.white,
            ),
            child: Text('Search'),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions() {
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
                'Filter Bookings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E5F4B),
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.date_range, color: Color(0xFF2A7F6E)),
                title: Text('Sort by Date'),
                subtitle: Text('Newest first'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Icon(Icons.attach_money, color: Color(0xFF2A7F6E)),
                title: Text('Sort by Amount'),
                subtitle: Text('Highest first'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Icon(Icons.star, color: Color(0xFF2A7F6E)),
                title: Text('Sort by Rating'),
                subtitle: Text('Highest rated'),
                onTap: () => Navigator.pop(context),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.electrical_services,
                  color: Color(0xFF2A7F6E),
                ),
                title: Text('Electrical Only'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Icon(Icons.plumbing, color: Color(0xFF2A7F6E)),
                title: Text('Plumbing Only'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _bookAgain(Map<String, dynamic> booking) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking ${booking['serviceType']} again...'),
        backgroundColor: Color(0xFF2A7F6E),
      ),
    );
    // Navigate to booking screen with pre-filled data
    // Navigator.pushNamed(context, '/booking_customer', arguments: {'service': booking['serviceType']});
  }

  void _trackBooking(Map<String, dynamic> booking) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tracking feature coming soon!'),
        backgroundColor: Color(0xFF2A7F6E),
      ),
    );
  }

  void _downloadReceipt(Map<String, dynamic> booking) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Receipt download feature coming soon!'),
        backgroundColor: Color(0xFF2A7F6E),
      ),
    );
  }
}
