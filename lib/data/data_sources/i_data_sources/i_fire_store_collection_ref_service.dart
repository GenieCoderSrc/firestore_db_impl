import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IFireStoreCollectionRefService {
  // Generates and returns a unique reference ID for a document in the specified Firestore collection.
  String getRefId(String path);

  // Returns a reference to the Firestore collection specified by the given path.
  Query<Map<String, dynamic>> getCollectionRef(String path);
}
