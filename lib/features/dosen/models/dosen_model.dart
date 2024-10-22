import 'package:siap/features/auth/models/user_model.dart';

class DosenModel extends UserModel {
  DosenModel({
    required String uid,
    required String name,
    required String email,
    required String username,
    required String password,
    required String department,
  }) : super(
          uid: uid,
          name: name,
          email: email,
          role: '2', // Specify the role as 'dosen'
          username: username,
          password: password,
          department: department, // Set department for Dosen
        );
}

