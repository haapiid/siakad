import 'package:flutter/material.dart';

class MahasiswaDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Dashboard Mahasiswa"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Greetings and User Info
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpg'), // Add a placeholder for the profile picture
                  radius: 30,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hai, Sheila Shafitri",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("1301100310 - Sistem Informasi", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            
            // Section: Indeks Prestasi
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Indeks Prestasi",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "Semester Lima",
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "3.53",
                        style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.notifications, color: Colors.white),
                      SizedBox(width: 10),
                      Icon(Icons.qr_code_scanner, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Section: Icons for Features
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              children: [
                _buildFeatureIcon(Icons.calendar_today, "Kalender"),
                _buildFeatureIcon(Icons.message, "Pesan"),
                _buildFeatureIcon(Icons.folder, "Repositori"),
                _buildFeatureIcon(Icons.check_circle_outline, "Presensi"),
                _buildFeatureIcon(Icons.payment, "UKT"),
                _buildFeatureIcon(Icons.note, "Catatan"),
                _buildFeatureIcon(Icons.school, "Transkrip"),
                _buildFeatureIcon(Icons.more_horiz, "Lainnya"),
              ],
            ),
            SizedBox(height: 20),

            // Section: Jadwal Hari Ini
            _buildScheduleCard(),

            SizedBox(height: 20),

            // Section: Informasi Kuliah
            _buildInfoCard(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Berita'),
          BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'Hasil Studi'),
          BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Jadwal'),
        ],
        selectedItemColor: Colors.blueAccent,
      ),
    );
  }

  // Helper method to build feature icons
  Widget _buildFeatureIcon(IconData iconData, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData, size: 40, color: Colors.blueAccent),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  // Helper method to build the schedule card
  Widget _buildScheduleCard() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text("8.30", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sistem Operasi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Ruang AM 201", style: TextStyle(fontSize: 14)),
              Text("Dosen: Asep Taufik, S.T., M.T.I.", style: TextStyle(fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }

  // Helper method to build the information card
  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.campaign, size: 40, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Beasiswa Magang Bersertifikat di Perusahaan BUMN", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
