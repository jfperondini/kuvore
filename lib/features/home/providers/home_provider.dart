import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/home_repository.dart';
import '../../auth/providers/auth_provider.dart';

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepository(FirebaseFirestore.instance),
);

final contractedProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final user = ref.watch(authUserProvider).value;
  if (user == null) return [];

  try {
    return await ref.watch(homeRepositoryProvider).contracted(user.uid);
  } catch (_) {
    return [];
  }
});
