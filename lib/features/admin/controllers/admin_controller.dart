import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUserController extends ChangeNotifier {
  String _searchQuery = '';
  int _perPage = 10;
  DocumentSnapshot? _lastDocument;
  bool _isLoading = false;
  List<DocumentSnapshot> _users = [];

  bool _isAddingUser = false;
  String? _selectedRole;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Load initial users
  Future<void> loadUsers({bool loadMore = false}) async {
    if (_isLoading) return;
    setLoadingState(true);

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

    setLoadingState(false);
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    searchUsers(_searchQuery);
  }

  // Search Users
  Future<void> searchUsers(String query) async {
    setLoadingState(true);

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .limit(_perPage)
        .get();

    _users = snapshot.docs;
    setLoadingState(false);
  }

  // Save user to Firestore
  Future<void> saveUser() async {
    final Map<String, dynamic> userData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'role': _selectedRole,
      'createdAt': DateTime.now(),
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
    setIsAddingUser(false);
    resetForm();
    loadUsers();
  }

  // Delete user
  Future<void> deleteUser(String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).delete();
    loadUsers();
  }

  // Manage form state
  void setIsAddingUser(bool value) {
    _isAddingUser = value;
    notifyListeners();
  }

  void resetForm() {
    _nameController.clear();
    _emailController.clear();
    _nimController.clear();
    _classController.clear();
    _departmentController.clear();
    _usernameController.clear();
    _passwordController.clear();
    _selectedRole = null;
    notifyListeners();
  }

  void setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Getters
  bool get isAddingUser => _isAddingUser;
  bool get isLoading => _isLoading;
  List<DocumentSnapshot> get users => _users;
  String? get selectedRole => _selectedRole;
  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get nimController => _nimController;
  TextEditingController get classController => _classController;
  TextEditingController get departmentController => _departmentController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;

  // Role Setter
  void setSelectedRole(String? value) {
    _selectedRole = value;
    notifyListeners();
  }
}
