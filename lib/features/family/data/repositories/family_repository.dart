import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/family_member_model.dart';

class FamilyRepository {
  FamilyRepository(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _collection(String uid) =>
      _firestore.collection('users').doc(uid).collection('family');

  Stream<List<FamilyMemberModel>> watch(String uid) {
    return _collection(uid).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => FamilyMemberModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> add(String uid, FamilyMemberModel member) =>
      _collection(uid).add(member.toMap());

  Future<void> remove(String uid, String id) =>
      _collection(uid).doc(id).delete();
}
