import 'package:flutter/material.dart';
import 'package:siap/features/admin/views/admin_dashboard_page.dart';
import 'package:siap/features/auth/views/login_page.dart';
import 'package:siap/features/dosen/views/dosen_dashboard_page.dart';
import 'package:siap/features/dosen/views/dosen_dashboard_page.dart';
import 'package:siap/features/mahasiswa/views/mahasiswa_dashboard_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => LoginPage(),
    '/admin/dashboard': (context) => AdminDashboardPage(),
    '/dosen/dashboard': (context) => DosenDashbordPage(),
    '/mahasiswa/dashboard': (context) => MahasiswaDashboardPage(),
  };
}
