import 'package:flutter/material.dart';

class ProfileCustomerScreen extends StatefulWidget {
  @override
  _ProfileCustomerScreenState createState() => _ProfileCustomerScreenState();
}

class _ProfileCustomerScreenState extends State<ProfileCustomerScreen> {
  bool _isEditing = false;

  // User data
  String _fullName = "Maria Santos Cruz";
  String _mobileNumber = "+63 912 345 6789";
  String _email = "maria.cruz@example.com";
  String _address = "123 Bonifacio St., Makati City, Metro Manila";

  // Controllers for editing
  late TextEditingController _nameController;
  late TextEditingController _mobileController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _fullName);
    _mobileController = TextEditingController(text: _mobileNumber);
    _emailController = TextEditingController(text: _email);
    _addressController = TextEditingController(text: _address);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    setState(() {
      _fullName = _nameController.text;
      _mobileNumber = _mobileController.text;
      _email = _emailController.text;
      _address = _addressController.text;
      _isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Color(0xFF2A7F6E),
      ),
    );
  }

  void _cancelEdit() {
    setState(() {
      _nameController.text = _fullName;
      _mobileController.text = _mobileNumber;
      _emailController.text = _email;
      _addressController.text = _address;
      _isEditing = false;
    });
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
        title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF1E5F4B),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (!_isEditing)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
            ),
          if (_isEditing) ...[
            IconButton(icon: Icon(Icons.check), onPressed: _saveChanges),
            IconButton(icon: Icon(Icons.close), onPressed: _cancelEdit),
          ],
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Picture
            Container(
              margin: EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xFF2A7F6E).withOpacity(0.1),
                        backgroundImage: AssetImage(
                          'assets/profile_placeholder.png',
                        ),
                        child: _isEditing
                            ? null
                            : Icon(
                                Icons.person,
                                size: 60,
                                color: Color(0xFF2A7F6E),
                              ),
                      ),
                      if (_isEditing)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Color(0xFF2A7F6E),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (_isEditing)
                    TextButton(
                      onPressed: () {
                        // Handle change photo
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Change photo feature coming soon!'),
                            backgroundColor: Color(0xFF2A7F6E),
                          ),
                        );
                      },
                      child: Text(
                        'Change Photo',
                        style: TextStyle(color: Color(0xFF2A7F6E)),
                      ),
                    ),
                ],
              ),
            ),

            // Account Information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E5F4B),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Full Name
                  _buildProfileField(
                    icon: Icons.person_outline,
                    label: 'Full Name',
                    value: _fullName,
                    controller: _nameController,
                    isEditing: _isEditing,
                  ),

                  // Mobile Number
                  _buildProfileField(
                    icon: Icons.phone,
                    label: 'Mobile Number',
                    value: _mobileNumber,
                    controller: _mobileController,
                    isEditing: _isEditing,
                    keyboardType: TextInputType.phone,
                  ),

                  // Email
                  _buildProfileField(
                    icon: Icons.email,
                    label: 'Email',
                    value: _email,
                    controller: _emailController,
                    isEditing: _isEditing,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  // Address
                  _buildProfileField(
                    icon: Icons.location_on,
                    label: 'Address',
                    value: _address,
                    controller: _addressController,
                    isEditing: _isEditing,
                    maxLines: 2,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Additional Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
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
                  _buildSettingsTile(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Change password!'),
                          backgroundColor: Color(0xFF2A7F6E),
                        ),
                      );
                    },
                  ),
                  _buildSettingsTile(
                    icon: Icons.lock_outline,
                    title: 'Confirm Password',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Confirm password!'),
                          backgroundColor: Color(0xFF2A7F6E),
                        ),
                      );
                    },
                  ),
                  Divider(),
                  _buildSettingsTile(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Privacy policy coming soon!'),
                          backgroundColor: Color(0xFF2A7F6E),
                        ),
                      );
                    },
                  ),
                  Divider(),
                  _buildSettingsTile(
                    icon: Icons.logout,
                    title: 'Logout',
                    color: Colors.red,
                    onTap: () {
                      _showLogoutDialog();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required IconData icon,
    required String label,
    required String value,
    required TextEditingController controller,
    required bool isEditing,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            child: Icon(icon, color: Color(0xFF2A7F6E), size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                if (isEditing)
                  TextField(
                    controller: controller,
                    keyboardType: keyboardType,
                    maxLines: maxLines,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color(0xFF2A7F6E),
                          width: 2,
                        ),
                      ),
                    ),
                  )
                else
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
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

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = const Color(0xFF1E5F4B),
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey[400],
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
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
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog

              // Redirect to /home and remove all previous routes
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logged out successfully'),
                  backgroundColor: Color(0xFF2A7F6E),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
