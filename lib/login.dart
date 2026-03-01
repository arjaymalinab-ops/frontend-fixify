import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

enum UserRole { customer, handyman, superAdmin }

class LoginPage extends StatefulWidget {
  final UserRole? initialRole;
  final String?
  userEmail; // Optional: pre-fill email if coming from registration

  const LoginPage({Key? key, this.initialRole, this.userEmail})
    : super(key: key);

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

      // call backend
      UserRole? userRole = await _authenticateUser(email, password);

      if (userRole != null) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Welcome back! Logging in as ${_getRoleName(userRole)}',
            ),
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
    final uri = Uri.parse('$backendUrl/api/auth/login');
    try {
      final res = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final roleStr = data['role'] as String?;
        if (roleStr == 'customer') return UserRole.customer;
        if (roleStr == 'handyman') return UserRole.handyman;
        if (roleStr == 'admin' ||
            roleStr == 'superadmin' ||
            roleStr == 'superAdmin')
          return UserRole.superAdmin;
      }
    } catch (e) {
      print('login error: $e');
    }
    return null;
  }

  void _navigateBasedOnRole(UserRole role) {
    switch (role) {
      case UserRole.customer:
        Navigator.pushReplacementNamed(context, '/dashboard_customer');
        break;
      case UserRole.handyman:
        Navigator.pushReplacementNamed(context, '/dashboard_handyman');
        break;
      case UserRole.superAdmin:
        Navigator.pushReplacementNamed(context, '/dashboard_superadmin');
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
              backgroundColor: Colors.white.withOpacity(0.2),
              radius: 20,
              child: ClipOval(
                child: Image.asset(
                  'assets/wbackground.jpg', // or 'assets/nobackground.png'
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Show fallback icon if image fails to load
                    return Icon(Icons.handyman, color: Colors.white, size: 20);
                  },
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'AYO',
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
                        padding: EdgeInsets.all(1), // Increased from 20 to 30
                        decoration: BoxDecoration(
                          color: Color(0xFF2A7F6E).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          radius: 80, // Increased from 20 to 40
                          child: ClipOval(
                            child: Image.asset(
                              'assets/wbackground.jpg',
                              width: 150, // Increased from 50 to 80
                              height: 150, // Increased from 50 to 80
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.handyman,
                                  color: Colors.white,
                                  size: 80,
                                );
                              },
                            ),
                          ),
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
                        'Login to your AYO account',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Color(0xFF2A7F6E),
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
                      borderSide: BorderSide(
                        color: Color(0xFF2A7F6E),
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
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
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Color(0xFF2A7F6E),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
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
                      borderSide: BorderSide(
                        color: Color(0xFF2A7F6E),
                        width: 2,
                      ),
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
                          content: Text(
                            'Password reset link sent to your email',
                          ),
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
