import 'package:cloud_firestore/cloud_firestore.dart';

import 'i_data_sources/i_fire_store_collection_ref_service.dart';

class FireStoreCollectionRefServiceImpl extends IFireStoreCollectionRefService {
  final FirebaseFirestore _fireStoreDb;

  FireStoreCollectionRefServiceImpl({FirebaseFirestore? fireStoreDb})
    : _fireStoreDb = fireStoreDb ?? FirebaseFirestore.instance;

  @override
  // CollectionReference<Object?>
  Query<Map<String, dynamic>> getCollectionRef(String path) =>
      _fireStoreDb.collection(path);

  @override
  String getRefId(String path) => _fireStoreDb.collection(path).doc().id;
}
