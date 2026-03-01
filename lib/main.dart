import 'package:flutter/material.dart';
import 'config.dart';
import 'home.dart';
import 'login.dart';

import 'customerpages/register_customer.dart';
import 'customerpages/dashboard_customer.dart';
import 'customerpages/booking_customer.dart';
import 'customerpages/notification_customer.dart';
import 'customerpages/profile_customer.dart';
import 'customerpages/bookinghistory_customer.dart';
import 'customerpages/mybookings_customer.dart';

import 'handymanpages/register_handyman.dart';
import 'handymanpages/dashboard_handyman.dart';

import 'superadminpages/dashboard_superadmin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // backendUrl is imported from config.dart
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Auth Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>?;
          return LoginPage(
            initialRole: args != null && args['initialRole'] != null
                ? (args['initialRole'] == 'customer'
                      ? null // LoginPage doesn't use role directly for now
                      : null)
                : null,
            userEmail: args != null ? args['userEmail'] as String? : null,
          );
        },
        '/register_customer': (context) => RegisterPageCustomer(),
        '/register_handyman': (context) => RegisterPageHandyman(),
        '/notification_customer': (context) => NotificationCustomerScreen(),
        '/profile_customer': (context) => ProfileCustomerScreen(),
        '/dashboard_customer': (context) => CustomerDashboard(),
        '/bookinghistory_customer': (context) => BookingHistoryScreen(),
        '/mybookings_customer': (context) => MyBookingsScreen(),
        '/dashboard_handyman': (context) => HandymanDashboard(),
        '/dashboard_superadmin': (context) => AdminDashboard(),
        '/booking_customer': (context) => BookingCustomerScreen(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
