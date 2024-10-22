import 'package:siap/features/auth/models/user_model.dart';

class AdminModel extends UserModel {
  // Additional attributes specific to Admin can be added here

  AdminModel({
    required String uid,
    required String name,
    required String email,
    required String username,
    required String password,
  }) : super(
          uid: uid,
          name: name,
          email: email,
          role: '1', // Specify the role as 'admin'
          username: username,
          password: password,
        );
}
