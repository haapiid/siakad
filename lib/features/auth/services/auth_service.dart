import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> authenticate(String username, String password) async {
    try {
      // Ambil dokumen pengguna berdasarkan username
      QuerySnapshot query = await _firestore
          .collection('users') // Ganti dengan nama koleksi pengguna Anda
          .where('username', isEqualTo: username)
          .get();

      if (query.docs.isNotEmpty) {
        var userData = query.docs.first.data() as Map<String, dynamic>;
        
        // Cek apakah password sesuai
        if (userData['password'] == password) {
          // Autentikasi berhasil, kembalikan role pengguna
          return {
            'isAuthenticated': true,
            'role': userData['role'] // role misalnya 1 untuk admin, 2 untuk dosen, 3 untuk mahasiswa
          };
        } else {
          return {'isAuthenticated': false};
        }
      }
      return {'isAuthenticated': false};
    } catch (e) {
      print('Error during authentication: $e');
      return {'isAuthenticated': false};
    }
  }
}
