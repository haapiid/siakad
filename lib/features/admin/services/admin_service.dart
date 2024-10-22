import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> loadUsers({DocumentSnapshot? lastDocument, int limit = 10}) {
    Query query = _firestore.collection('users').orderBy('name').limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.get();
  }

  Future<QuerySnapshot> searchUsers(String query, int limit) {
    return _firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .limit(limit)
        .get();
  }

  Future<void> saveUser(Map<String, dynamic> userData) {
    return _firestore.collection('users').add(userData);
  }

  Future<void> deleteUser(String userId) {
    return _firestore.collection('users').doc(userId).delete();
  }
}