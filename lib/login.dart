import 'package:flutter/material.dart';

enum UserRole {
  customer,
  handyman,
  superAdmin,
}

class LoginPage extends StatefulWidget {
  final UserRole? initialRole;
  final String? userEmail; // Optional: pre-fill email if coming from registration
  
  const LoginPage({Key? key, this.initialRole, this.userEmail}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill email if provided (e.g., from registration)
    if (widget.userEmail != null) {
      _emailController.text = widget.userEmail!;
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      // Simulate API call
      await Future.delayed(Duration(seconds: 1));

      // In a real app, you would authenticate with your backend
      // The backend should return the user's role along with the authentication result
      
      // Mock authentication - In production, this should be handled by backend
      UserRole? userRole = await _authenticateUser(email, password);
      
      if (userRole != null) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome back! Logging in as ${_getRoleName(userRole)}'),
            backgroundColor: Color(0xFF2A7F6E),
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate based on role from database
        _navigateBasedOnRole(userRole);
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or password'),
            backgroundColor: Colors.red,
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  // Mock authentication - In production, this would be an API call to your backend
  Future<UserRole?> _authenticateUser(String email, String password) async {
    // Simulate API delay
    await Future.delayed(Duration(milliseconds: 500));
    
    // This is where you would verify credentials with your database
    // and return the actual role from the database
    
    // Mock database lookup based on email patterns
    // In production, this would come from your backend
    if (email.isEmpty || password.isEmpty) return null;
    
    // Demo credentials for different roles (simulating database lookup)
    if (email.contains('customer') || email == 'customer@test.com') {
      return UserRole.customer;
    } else if (email.contains('handyman') || email == 'handyman@test.com') {
      return UserRole.handyman;
    } else if (email.contains('admin') || email == 'admin@test.com') {
      return UserRole.superAdmin;
    }
    
    return null; // Authentication failed
  }

  void _navigateBasedOnRole(UserRole role) {
    switch (role) {
      case UserRole.customer:
        Navigator.pushReplacementNamed(context, '/customer-dashboard');
        break;
      case UserRole.handyman:
        Navigator.pushReplacementNamed(context, '/handyman-dashboard');
        break;
      case UserRole.superAdmin:
        Navigator.pushReplacementNamed(context, '/admin-dashboard');
        break;
    }
  }

  String _getRoleName(UserRole role) {
    switch (role) {
      case UserRole.customer:
        return 'Customer';
      case UserRole.handyman:
        return 'Handyman';
      case UserRole.superAdmin:
        return 'Super Admin';
    }
  }

  // Quick navigation buttons for each dashboard
  void _goToCustomerDashboard() {
    Navigator.pushReplacementNamed(context, '/customer-dashboard');
  }

  void _goToHandymanDashboard() {
    Navigator.pushReplacementNamed(context, '/handyman-dashboard');
  }

  void _goToAdminDashboard() {
    Navigator.pushReplacementNamed(context, '/admin-dashboard');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1E5F4B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFF2A7F6E).withOpacity(0.1),
              radius: 16,
              child: Icon(Icons.handyman, color: Color(0xFF2A7F6E), size: 16),
            ),
            SizedBox(width: 8),
            Text(
              'HandyLink PH',
              style: TextStyle(
                color: Color(0xFF1E5F4B),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFF2A7F6E).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.lock_outline,
                          size: 48,
                          color: Color(0xFF2A7F6E),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E5F4B),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Login to your HandyLink PH account',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 32),
                
                // Email Field
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF2A7F6E)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xFF2A7F6E), width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16),
                
                // Password Field
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF2A7F6E)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xFF2A7F6E), width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 12),
                
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Navigate to forgot password
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password reset link sent to your email'),
                          backgroundColor: Color(0xFF2A7F6E),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF2A7F6E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 24),
                
                // Login Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2A7F6E),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                
                SizedBox(height: 20),
                
                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Show registration options
                        _showRegistrationOptions();
                      },
                      child: Text(
                        'Register here',
                        style: TextStyle(
                          color: Color(0xFF2A7F6E),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 32),
                
                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300])),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Quick Access',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[300])),
                  ],
                ),
                
                SizedBox(height: 24),
                
                // Quick Dashboard Access Buttons
                Text(
                  'Go directly to dashboards:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E5F4B),
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Customer Dashboard Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard_customer');
                  },
                  icon: Icon(Icons.person, color: Colors.white),
                  label: Text('Customer Dashboard'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2A7F6E),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                
                SizedBox(height: 12),
                
                // Handyman Dashboard Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard_handyman');
                  },
                  icon: Icon(Icons.handyman, color: Colors.white),
                  label: Text('Handyman Dashboard'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E5F4B),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                
                SizedBox(height: 12),
                
                // Admin Dashboard Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard_superadmin');
                  },
                  icon: Icon(Icons.admin_panel_settings, color: Colors.white),
                  label: Text('Super Admin Dashboard'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[700],
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Note about these buttons
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRegistrationOptions() {
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
                'Register as',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E5F4B),
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF2A7F6E).withOpacity(0.1),
                  child: Icon(Icons.person, color: Color(0xFF2A7F6E)),
                ),
                title: Text('Customer'),
                subtitle: Text('Book verified handymen for your home repairs'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/register_customer');
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF2A7F6E).withOpacity(0.1),
                  child: Icon(Icons.handyman, color: Color(0xFF2A7F6E)),
                ),
                title: Text('Handyman'),
                subtitle: Text('Join our platform and grow your business'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/register_handyman');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}