import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/family_member_model.dart';
import '../data/repositories/family_repository.dart';
import '../../auth/providers/auth_provider.dart';

final familyRepositoryProvider = Provider<FamilyRepository>(
  (ref) => FamilyRepository(FirebaseFirestore.instance),
);

final familyMembersProvider = StreamProvider<List<FamilyMemberModel>>((ref) {
  final uid = ref.watch(authUserProvider).value?.uid;
  if (uid == null) return const Stream.empty();
  return ref.watch(familyRepositoryProvider).watch(uid);
});
