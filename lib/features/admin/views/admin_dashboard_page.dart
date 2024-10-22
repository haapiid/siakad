import 'package:flutter/material.dart';
import 'package:siap/features/admin/views/admin_user_magement_page.dart';

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  String selectedMenu = 'Dashboard';
  bool isSidebarOpen = true; // Untuk melacak apakah sidebar terbuka atau tertutup
  final double sidebarWidthClosed = 70; // Lebar sidebar saat tertutup
  final double sidebarWidthOpen = 250; // Lebar sidebar saat terbuka

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.person),
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar Menu
          AnimatedContainer(
            duration: Duration(milliseconds: 300), // Animasi perubahan lebar
            width: isSidebarOpen ? sidebarWidthOpen : sidebarWidthClosed,
            color: Colors.blue.shade700,
            child: Column(
              children: [
                DrawerHeader(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(
                        isSidebarOpen ? Icons.arrow_back_ios : Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isSidebarOpen = !isSidebarOpen; // Toggle sidebar
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      _buildMenuItem('Dashboard', Icons.dashboard),
                      _buildMenuItem('Manajemen Pengguna', Icons.people),
                      _buildMenuItem('Manajemen Kelas', Icons.class_),
                      _buildMenuItem('Manajemen Mata Kuliah', Icons.book),
                      _buildMenuItem('Manajemen Nilai', Icons.score),
                      _buildMenuItem('Manajemen Jadwal', Icons.schedule),
                      _buildMenuItem('Monitoring Aktivitas', Icons.monitor),
                      _buildMenuItem('Manajemen Pengumuman', Icons.announcement),
                      _buildMenuItem('Laporan dan Statistik', Icons.bar_chart),
                      _buildMenuItem('Pengaturan Akun', Icons.settings),
                      _buildMenuItem('Backup & Restore Data', Icons.backup),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main Content Area
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildMainContent(),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk item menu
  Widget _buildMenuItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: isSidebarOpen
          ? Text(title, style: TextStyle(color: Colors.white)) // Tampilkan teks saat sidebar terbuka
          : null, // Hilangkan teks saat sidebar tertutup
      onTap: () {
        setState(() {
          selectedMenu = title;
        });
      },
    );
  }

  // Widget untuk konten utama
  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedMenu,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Expanded(
          child: _getSelectedContent(),
        ),
      ],
    );
  }

  // Fungsi untuk mendapatkan konten yang dipilih berdasarkan menu
Widget _getSelectedContent() {
  if (selectedMenu == 'Dashboard') {
    return Center(
      child: Text(
        'Selamat datang di Dashboard Admin',
        style: TextStyle(fontSize: 18),
      ),
    );
  } else if (selectedMenu == 'Manajemen Pengguna') {
    return UserManagementPage(); // Ini halaman manajemen pengguna
  } else {
    return Center(
      child: Text(
        'Content for $selectedMenu goes here.',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
}
