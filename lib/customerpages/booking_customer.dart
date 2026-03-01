import 'package:flutter/material.dart';

class BookingCustomerScreen extends StatefulWidget {
  @override
  _BookingCustomerScreenState createState() => _BookingCustomerScreenState();
}

class _BookingCustomerScreenState extends State<BookingCustomerScreen> {
  int _currentStep = 0;

  // Step 1: Service Type selection
  String? _selectedServiceType;
  final List<Map<String, dynamic>> _serviceTypes = [
    {
      'icon': Icons.electrical_services,
      'name': 'Electrician',
      'description': 'Wiring, outlets, fixtures',
    },
    {
      'icon': Icons.plumbing,
      'name': 'Plumber',
      'description': 'Faucets, pipes, water heater',
    },
    {
      'icon': Icons.construction,
      'name': 'Carpenter',
      'description': 'Furniture repair, installations',
    },
    {
      'icon': Icons.ac_unit,
      'name': 'Aircon Technician',
      'description': 'Cleaning, repair, maintenance',
    },
  ];

  // Step 2: Issue Description
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _issueTitleController = TextEditingController();

  // Step 3: Location
  final TextEditingController _locationController = TextEditingController(
    text: '123 Bonifacio St., Makati City, Metro Manila',
  );

  @override
  void dispose() {
    _descriptionController.dispose();
    _issueTitleController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _submitBooking() {
    // Here you would handle the booking submission
    // Navigate to confirmation or back to dashboard
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Booking Submitted'),
        content: Text('Your service request has been submitted successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to dashboard
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request Service',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1E5F4B),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Step Indicator
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepIndicator(1, 'Service', _currentStep >= 0),
                Container(
                  width: 40,
                  height: 2,
                  color: _currentStep >= 1
                      ? Color(0xFF2A7F6E)
                      : Colors.grey[300],
                ),
                _buildStepIndicator(2, 'Describe', _currentStep >= 1),
                Container(
                  width: 40,
                  height: 2,
                  color: _currentStep >= 2
                      ? Color(0xFF2A7F6E)
                      : Colors.grey[300],
                ),
                _buildStepIndicator(3, 'Location', _currentStep >= 2),
                Container(
                  width: 40,
                  height: 2,
                  color: _currentStep >= 3
                      ? Color(0xFF2A7F6E)
                      : Colors.grey[300],
                ),
                _buildStepIndicator(4, 'Confirm', _currentStep >= 3),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: IndexedStack(
              index: _currentStep,
              children: [
                _buildServiceTypeStep(),
                _buildDescribeIssueStep(),
                _buildLocationStep(),
                _buildConfirmationStep(),
              ],
            ),
          ),

          // Navigation Buttons
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFF2A7F6E),
                        side: BorderSide(color: Color(0xFF2A7F6E)),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Back'),
                    ),
                  ),
                if (_currentStep > 0) SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentStep == 3 ? _submitBooking : _nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2A7F6E),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(_currentStep == 3 ? 'Submit' : 'Next'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Color(0xFF2A7F6E) : Colors.grey[300],
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Color(0xFF2A7F6E) : Colors.grey[600],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // Step 1: Select Service Type
  Widget _buildServiceTypeStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Service Type',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Choose the type of service you need',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 20),
          ..._serviceTypes
              .map((service) => _buildServiceTypeCard(service))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildServiceTypeCard(Map<String, dynamic> service) {
    bool isSelected = _selectedServiceType == service['name'];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedServiceType = service['name'];
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF2A7F6E).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Color(0xFF2A7F6E) : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? Color(0xFF2A7F6E)
                    : Color(0xFF2A7F6E).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                service['icon'],
                color: isSelected ? Colors.white : Color(0xFF2A7F6E),
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E5F4B),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    service['description'],
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: Color(0xFF2A7F6E), size: 24),
          ],
        ),
      ),
    );
  }

  // Step 2: Describe Issue
  Widget _buildDescribeIssueStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Describe the Issue',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please describe the issue in detail',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 20),

          // Issue Title
          TextField(
            controller: _issueTitleController,
            decoration: InputDecoration(
              labelText: 'Problem Title',
              hintText: 'e.g., Faulty electrical outlet',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFF2A7F6E), width: 2),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Detailed Description
          TextField(
            controller: _descriptionController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Problem Description',
              hintText: 'Please describe the issue in detail...',
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFF2A7F6E), width: 2),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Upload Photo Section
          Text(
            'Upload Photo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              // Handle image upload
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Photo upload feature coming soon!'),
                  backgroundColor: Color(0xFF2A7F6E),
                ),
              );
            },
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[300]!,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload, size: 40, color: Colors.grey[400]),
                  SizedBox(height: 8),
                  Text(
                    'Tap to upload a photo',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    'Optional',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Step 3: Pin Location
  Widget _buildLocationStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pin Your Location',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tap on the map to pin your exact location',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 20),

          // Map Placeholder (Interactive Map)
          GestureDetector(
            onTap: () {
              // Handle map interaction
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Map interaction coming soon!'),
                  backgroundColor: Color(0xFF2A7F6E),
                ),
              );
            },
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage('assets/map_placeholder.png'),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    // If image fails to load, show placeholder
                  },
                ),
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.touch_app, color: Color(0xFF2A7F6E)),
                      SizedBox(width: 8),
                      Text(
                        'Tap to pin your exact location',
                        style: TextStyle(color: Color(0xFF1E5F4B)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Selected Location
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF2A7F6E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Location:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E5F4B),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Color(0xFF2A7F6E), size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _locationController.text,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () {
                    // Handle edit location
                  },
                  icon: Icon(Icons.edit, size: 16),
                  label: Text('Edit Location'),
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xFF2A7F6E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Step 4: Confirmation
  Widget _buildConfirmationStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review Your Request',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please review the details before submitting',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 20),

          // Service Type Summary
          _buildSummaryCard(
            icon: Icons.build,
            title: 'Service Type',
            content: _selectedServiceType ?? 'Not selected',
          ),
          SizedBox(height: 12),

          // Issue Summary
          _buildSummaryCard(
            icon: Icons.description,
            title: 'Issue Details',
            content: _issueTitleController.text.isEmpty
                ? 'No title provided'
                : _issueTitleController.text,
            subtitle: _descriptionController.text.isEmpty
                ? null
                : _descriptionController.text,
          ),
          SizedBox(height: 12),

          // Location Summary
          _buildSummaryCard(
            icon: Icons.location_on,
            title: 'Service Location',
            content: _locationController.text,
          ),
          SizedBox(height: 20),

          // Terms and Conditions
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFF2A7F6E), size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'By submitting, you agree to our Terms of Service and Privacy Policy',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String content,
    String? subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF2A7F6E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Color(0xFF2A7F6E), size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E5F4B),
                  ),
                ),
                if (subtitle != null && subtitle.isNotEmpty) ...[
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
