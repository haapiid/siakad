import 'package:siap/features/auth/models/user_model.dart';

class MahasiswaModel extends UserModel {
  MahasiswaModel({
    required String uid,
    required String name,
    required String email,
    required String username,
    required String password,
    required String nim,
    required String className,
  }) : super(
          uid: uid,
          name: name,
          email: email,
          role: '3', // Specify the role as 'mahasiswa'
          username: username,
          password: password,
          nim: nim, // Set NIM for Mahasiswa
          className: className, // Set class name for Mahasiswa
        );
}
