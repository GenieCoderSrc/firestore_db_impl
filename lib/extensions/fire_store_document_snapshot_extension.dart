import 'package:cloud_firestore/cloud_firestore.dart';

extension FirestoreDocumentSnapshotExtension on DocumentSnapshot<Object?>? {
  T? toModel<T>(T Function(Map<String, dynamic>) fromJson, String idField) {
    if (this == null || !this!.exists) {
      return null;
    }

    final Map<String, dynamic>? data = this!.data() as Map<String, dynamic>?;

    if (data == null) {
      return null;
    }

    data[idField] = this!.id;
    return fromJson(data);
  }
}
