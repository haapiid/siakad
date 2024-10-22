class UserModel {
  String uid;
  String name;
  String email;
  String role;
  String username;
  String password;
  String? nim; // Nullable for non-students
  String? className; // Nullable for non-students
  String? department; // Nullable for non-lecturers

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.username,
    required this.password,
    this.nim,
    this.className,
    this.department,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'username': username,
      'password': password,
      if (nim != null) 'nim': nim,
      if (className != null) 'class': className,
      if (department != null) 'department': department,
      'createdAt': DateTime.now(),
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      role: map['role'],
      username: map['username'],
      password: map['password'],
      nim: map['nim'],
      className: map['class'],
      department: map['department'],
    );
  }
}
