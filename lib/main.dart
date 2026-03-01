import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';

import 'customerpages/register_customer.dart';
import 'customerpages/dashboard_customer.dart';

import 'handymanpages/register_handyman.dart';
import 'handymanpages/dashboard_handyman.dart';

import 'superadminpages/dashboard_superadmin.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Auth Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register_customer': (context) => RegisterPageCustomer(),
        '/register_handyman': (context) => RegisterPageHandyman(),
        '/dashboard_customer': (context) => CustomerDashboard(),
        '/dashboard_handyman': (context) => HandymanDashboard(),
        '/dashboard_superadmin': (context) => AdminDashboard(),
      },
    );
  }
}
