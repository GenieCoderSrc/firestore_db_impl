import 'package:cloud_firestore/cloud_firestore.dart';

extension QuerySnapshotExtension on QuerySnapshot<Object?> {
  Map<String, dynamic>? toDocumentsData() {
    if (docs.isEmpty) {
      return null; // Return null if no documents are found
    }

    Map<String, dynamic> documentsData = {};
    for (var doc in docs) {
      documentsData[doc.id] = doc.data();
    }

    return documentsData;
  }

  List<Map<String, dynamic>?> toListOfMaps() {
    return docs.map((doc) => doc.data() as Map<String, dynamic>?).toList();
  }
}
