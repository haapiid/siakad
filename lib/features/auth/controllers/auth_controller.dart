import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Future<void> login(BuildContext context, String nim, String password) async {
    try {
      // Ambil hasil autentikasi dan role dari AuthService
      final result = await _authService.authenticate(nim, password);

      if (result['isAuthenticated']) {
        String role = result['role'];  // Role dari AuthService

        // Navigasi ke halaman berdasarkan role
        if (role == '1') {
          Navigator.pushReplacementNamed(context, '/admin/dashboard');
        } else if (role == '2') {
          Navigator.pushReplacementNamed(context, '/dosen/dashboard');
        } else if (role == '3') {
          Navigator.pushReplacementNamed(context, '/mahasiswa/dashboard');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Role not recognized'))
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: Invalid credentials'))
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during login: $e')),
      );
    }
  }
}
