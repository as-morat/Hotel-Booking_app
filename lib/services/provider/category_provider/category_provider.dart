import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'category_services.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final categoryServiceProvider = Provider(
  (ref) => CategoryService(ref.watch(firestoreProvider)),
);

