import 'package:cloud_firestore/cloud_firestore.dart';

class HomeRepository {
  HomeRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Future<List<Map<String, dynamic>>> contracted(String uid) async {
    final result = await _firestore
        .collection('users')
        .doc(uid)
        .collection('contracts')
        .get();

    return result.docs.map((doc) => doc.data()).toList();
  }
}
