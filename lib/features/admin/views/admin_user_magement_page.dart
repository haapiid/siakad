import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  String _searchQuery = '';
  int _perPage = 10;
  DocumentSnapshot? _lastDocument;
  bool _isLoading = false;
  List<DocumentSnapshot> _users = [];

  // Form state variables
  bool _isAddingUser = false;
  String? _selectedRole;
  final TextEditingController _uidController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  // Load initial users
  void _loadUsers({bool loadMore = false}) async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    Query query = FirebaseFirestore.instance
        .collection('users')
        .orderBy('name')
        .limit(_perPage);

    if (loadMore && _lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    QuerySnapshot snapshot = await query.get();
    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
      if (loadMore) {
        _users.addAll(snapshot.docs);
      } else {
        _users = snapshot.docs;
      }
    }

    setState(() => _isLoading = false);
  }

  void _searchUsers(String query) async {
    setState(() => _isLoading = true);

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .limit(_perPage)
        .get();

    setState(() {
      _users = snapshot.docs;
      _isLoading = false;
    });
  }

  // Save user to Firestore
  void _saveUser() async {
    final Map<String, dynamic> userData = {
      'uid': _uidController.text,
      'name': _nameController.text,
      'email': _emailController.text,
      'role': _selectedRole,
      'createdAt': DateTime.now(),
      'lastActive': DateTime.now(),
      'username': _usernameController.text,
      'password': _passwordController.text,
    };

    if (_selectedRole == '2' || _selectedRole == 'Dosen') {
      userData['department'] = _departmentController.text;
    } else if (_selectedRole == '3' || _selectedRole == 'Mahasiswa') {
      userData['nim'] = _nimController.text;
      userData['class'] = _classController.text;
    }

    await FirebaseFirestore.instance.collection('users').add(userData);
    setState(() {
      _isAddingUser = false;
      _resetForm();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User saved successfully')),
    );
    _loadUsers();
  }

  // Reset form fields
  void _resetForm() {
    _uidController.clear();
    _nameController.clear();
    _emailController.clear();
    _nimController.clear();
    _classController.clear();
    _departmentController.clear();
    _usernameController.clear();
    _passwordController.clear();
    _selectedRole = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add User Button and Search Field
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Search by name, email, or NIM',
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (query) {
                          _searchQuery = query;
                          _searchUsers(_searchQuery);
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isAddingUser = !_isAddingUser;
                        });
                      },
                      icon: Icon(Icons.add),
                      label: Text('Add new user'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Add User Form
                if (_isAddingUser) _buildAddUserForm(),
                // Users Table
                Expanded(
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _buildDataTable(),
                ),
                // Pagination Controls
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     TextButton(
                //       onPressed: () {
                //         // Load previous set of users
                //       },
                //       child: Text('Previous'),
                //     ),
                //     TextButton(
                //       onPressed: () {
                //         _loadUsers(loadMore: true);
                //       },
                //       child: Text('Next'),
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddUserForm() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Role Dropdown
      DropdownButtonFormField<String>(
        value: _selectedRole,
        items: [
          DropdownMenuItem(value: '1', child: Text('Admin')),
          DropdownMenuItem(value: '2', child: Text('Dosen')),
          DropdownMenuItem(value: '3', child: Text('Mahasiswa')),
        ],
        onChanged: (value) {
          setState(() {
            _selectedRole = value;
          });
        },
        decoration: InputDecoration(labelText: 'Select Role'),
      ),
      SizedBox(height: 10),

      // UID and Name Fields (Side by side)
      Row(
        children: [
          Expanded(child: _buildTextField(_nameController, 'Name')),
          SizedBox(width: 10),
          Expanded(child: _buildTextField(_emailController, 'Email')),
          SizedBox(width: 10),
          Expanded(child: _buildTextField(_usernameController, 'Username')),
        ],
      ),
      SizedBox(height: 10),

      // Password Field (Single row)
      _buildTextField(_passwordController, 'Password', obscureText: true),
      SizedBox(height: 10),

      // Conditionally Render Fields based on Role
      if (_selectedRole == '2' || _selectedRole == 'Dosen')
        // Department Field
        _buildTextField(_departmentController, 'Department'),

      if (_selectedRole == '3' || _selectedRole == 'Mahasiswa')
        Column(
          children: [
            // NIM and Class Fields (Side by side)
            Row(
              children: [
                Expanded(child: _buildTextField(_nimController, 'NIM')),
                SizedBox(width: 10), // Spacing between fields
                Expanded(child: _buildTextField(_classController, 'Class')),
              ],
            ),
          ],
        ),

      SizedBox(height: 20),
      
      // Save & Cancel Buttons
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                _isAddingUser = false;
                _resetForm();
              });
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _saveUser,
            child: Text('Save'),
          ),
        ],
      ),
    ],
  );
}

  Widget _buildTextField(TextEditingController controller, String label,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        obscureText: obscureText,
      ),
    );
  }

  Widget _buildDataTable() {
    if (_users.isEmpty) {
      return Center(child: Text('No users found.'));
    }

    return Expanded(
    child : SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Date Added')),
          DataColumn(label: Text('Last Active')),
          DataColumn(label: Text('Actions')),
        ],
        rows: _buildUserRows(_users),
      ),
    ),
    );
  }

  List<DataRow> _buildUserRows(List<DocumentSnapshot> users) {
    return users.map((user) {
      var userData = user.data() as Map<String, dynamic>;
      return DataRow(
        cells: <DataCell>[
          DataCell(Text(userData['name'] ?? '')),
          DataCell(Text(userData['email'] ?? '')),
          DataCell(Text(userData['dateAdded'] ?? '')),
          DataCell(Text(userData['lastActive'] ?? '')),
          DataCell(
  PopupMenuButton<int>(
    icon: Icon(Icons.more_vert),
    onSelected: (value) {
      if (value == 0) {
        // View profile functionality
        print("View profile selected");
        // Tambahkan logika untuk melihat profil
      } else if (value == 1) {
        // Edit functionality
        print("Edit selected");
        // Tambahkan logika untuk mengedit user
      } else if (value == 2) {
        // Delete functionality
        print("Delete selected");
        _deleteUser(user.id);  // Panggil fungsi untuk menghapus user
      } else if (value == 3) {
        // Permissions functionality
        print("Permissions selected");
        // Tambahkan logika untuk mengelola izin
      }
    },
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 0,
        child: Row(
          children: [
            Icon(Icons.visibility),
            SizedBox(width: 8),
            Text("View Profile"),
          ],
        ),
      ),
      PopupMenuItem(
        value: 1,
        child: Row(
          children: [
            Icon(Icons.edit),
            SizedBox(width: 8),
            Text("Edit"),
          ],
        ),
      ),
      PopupMenuItem(
        value: 2,
        child: Row(
          children: [
            Icon(Icons.delete),
            SizedBox(width: 8),
            Text("Delete"),
          ],
        ),
      ),
      PopupMenuItem(
        value: 3,
        child: Row(
          children: [
            Icon(Icons.security),
            SizedBox(width: 8),
            Text("Permissions"),
          ],
        ),
      ),
    ],
  ),
)

        ],
      );
    }).toList();
  }

  Future<void> _deleteUser(String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User deleted')),
    );
    _loadUsers();
  }
}
