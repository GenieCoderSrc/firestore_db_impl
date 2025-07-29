import 'package:cloud_firestore/cloud_firestore.dart';

// abstract class IFireStoreDbService {
//   FieldValue get serverTimestamp;
//   FieldValue get decrementFieldValue;
//   FieldValue get incrementFieldValue;
//   DateTime? getDateTimeFromServerTimeStamp(Timestamp serverTimestamp);
//
//   String getRefId(String path);
//   Query<Map<String, dynamic>> getCollectionRef(String path);
//
//   Query<Map<String, dynamic>> getCollectionRefWithWhere2(
//       {required String path,
//       required String field1,
//       required isEqualTo1,
//       required String field2,
//       required isEqualTo2});
//
//   // Query<Object?>
//   Query<Map<String, dynamic>> getCollectionRefWithWhere3({
//     required String path,
//     required String field1,
//     dynamic isEqualTo1,
//     required String field2,
//     dynamic isEqualTo2,
//     required String field3,
//     dynamic isEqualTo3,
//   });
//
//   //  Future Documents
//   Future<DocumentSnapshot<Object?>?> getDocumentById(
//       {required String path, required String id});
//
//   Future<dynamic> saveDocument(
//       {Map<String, dynamic>? data, required String path, String? successTxt});
//
//   Future<bool> addDocWithServerTime(
//       {required Map<String?, dynamic> data,
//       required String path,
//       required String timeField,
//       String? successTxt});
//
//   Future<bool> setDocument(
//       {required Map<String, dynamic> data,
//       required String path,
//       required String id,
//       String? successTxt});
//
//   Future<String?> setDocumentAutoId(
//       {required Map<String, dynamic> data,
//       required String path,
//       String? successTxt});
//
//   Future<bool> updateDocument(
//       {required Map<String, dynamic> data,
//       required String path,
//       required String id,
//       String? successTxt});
//
//   Future<bool> removeDocument({
//     required String path,
//     required String id,
//     String? successTxt,
//   });
//
//   Future<List<DocumentSnapshot<Object?>>>? searchData(
//       {required String searchKey,
//       required String path,
//       required String orderBy,
//       bool descending = false});
//
//   // Stream Documents
//   Stream<Object?>? streamDocumentById({required String path, String? id});
//
//   // Future Data
//   Future<QuerySnapshot<Map<String, dynamic>>?> getDataCollection(
//       {required String path,
//       int? limit,
//       String? orderByField,
//       bool? isDescending});
//
//   Future<QuerySnapshot<Map<String, dynamic>>?> getDataCollectionWithWhere(
//       {required String path, required String field, String? isEqualTo});
//
//   Future<QuerySnapshot<Map<String, dynamic>>?>
//       getDataCollectionWithWhereLimitOrderBy({
//     required String path,
//     required String whereField,
//     String? isEqualTo,
//     required String orderByField,
//     bool isDescending = false,
//     int limit = 50,
//   });
//
//   // Stream Data Collection
//
//   Stream<List<Object?>>? streamDataCollection(String path);
//
//   Stream<List<Object?>>? streamDataCollectionWithWhere({
//     required String path,
//     required String field,
//     dynamic isEqualTo,
//   });
//
//   Stream<List<Object?>>? streamDataCollectionWithWhere2({
//     required String path,
//     required String field1,
//     dynamic isEqualTo1,
//     required String field2,
//     dynamic isEqualTo2,
//   });
//
//   Stream<List<Object?>>? streamDataCollectionWithOrderBy(
//       {required String path,
//       required String orderByField,
//       bool descending = false});
//
//   Stream<List<Object?>>? streamDataCollectionWithOrderByAndLimit({
//     required String path,
//     required String orderByField,
//     bool descending = false,
//     required int limit,
//   });
//
//   Stream<List<Object?>>? streamCollectionWhereArrayContains(
//       {required String path,
//       required String field,
//       String? arrayContains,
//       required String orderByField,
//       bool descending = false});
//
//   Stream<List<Object?>>? streamCollectionWhereIn(
//       {required String path,
//       required String field,
//       List<Object?>? whereIn,
//       required String orderByField,
//       bool descending = false});
//
//   Stream<List<Object?>>? streamCollectionWhereInWithWhere(
//       {required String path,
//       required String field,
//       required dynamic isEqualTo,
//       required String whereInField,
//       required List<Object?> whereIn,
//       required String orderByField,
//       bool descending = false});
// }

abstract class IFireStoreDbService {
  // ---------- FireStore CRUD Operations ------------

  Future<dynamic> saveDocument({
    Map<String, dynamic>? data,
    required String path,
    String? successTxt,
  });

  Future<bool> addDocWithServerTime({
    required Map<String?, dynamic> data,
    required String path,
    required String timeField,
    String? successTxt,
  });

  Future<String?> setDocumentAutoId({
    required Map<String, dynamic> data,
    required String path,
    String? successTxt,
  });

  Future<bool> setDocument({
    required Map<String, dynamic> data,
    required String path,
    required String id,
    String? successTxt,
  });

  Future<bool> updateDocument({
    required Map<String, dynamic> data,
    required String path,
    required String id,
    String? successTxt,
  });

  Future<bool> removeDocument({
    required String path,
    required String id,
    String? successTxt,
  });

  // ---------- Get Single Future Data by ID ------------

  Future<DocumentSnapshot<Object?>?> getDocumentById({
    required String path,
    required String id,
  });

  // ---------- Get Single Stream Data by ID ------------

  Stream<Object?>? streamDocumentById({required String path, String? id});

  // ---------- Future Data Collections ------------

  Future<QuerySnapshot<Map<String, dynamic>>?> getDataCollection({
    required String path,
    int? limit,
    String? orderByField,
    bool? isDescending,
  });

  Future<QuerySnapshot<Map<String, dynamic>>?> getDataCollectionWithWhere({
    required String path,
    required String field,
    String? isEqualTo,
  });

  Future<QuerySnapshot<Map<String, dynamic>>?>
  getDataCollectionWithWhereLimitOrderBy({
    required String path,
    required String whereField,
    String? isEqualTo,
    required String orderByField,
    bool isDescending = false,
    int limit = 50,
  });

  // ---------- Get Collection Reference with Two Where Clauses ------------

  Query<Map<String, dynamic>> getCollectionRefWithWhere2({
    required String path,
    required String field1,
    required isEqualTo1,
    required String field2,
    required isEqualTo2,
  });

  // ---------- Get Collection Reference with Three Where Clauses ------------

  Query<Map<String, dynamic>> getCollectionRefWithWhere3({
    required String path,
    required String field1,
    dynamic isEqualTo1,
    required String field2,
    dynamic isEqualTo2,
    required String field3,
    dynamic isEqualTo3,
  });

  // ---------- Get Stream Data Collections ------------

  Stream<List<Object?>>? streamDataCollection(String path);

  // ---------- Stream Collection Operations With Conditions ------------

  Stream<List<Object?>>? streamDataCollectionWithOrderBy({
    required String path,
    required String orderByField,
    bool descending = false,
  });

  Stream<List<Object?>>? streamDataCollectionWithOrderByAndLimit({
    required String path,
    required String orderByField,
    bool descending = false,
    required int limit,
  });

  Stream<List<Object?>>? streamDataCollectionWithWhere({
    required String path,
    required String field,
    dynamic isEqualTo,
  });

  Stream<List<Object?>>? streamDataCollectionWithWhere2({
    required String path,
    required String field1,
    dynamic isEqualTo1,
    required String field2,
    dynamic isEqualTo2,
  });

  Stream<List<Object?>>? streamCollectionWhereArrayContains({
    required String path,
    required String field,
    String? arrayContains,
    required String orderByField,
    bool descending = false,
  });

  Stream<List<Object?>>? streamCollectionWhereIn({
    required String path,
    required String field,
    List<Object?>? whereIn,
    required String orderByField,
    bool descending = false,
  });

  Stream<List<Object?>>? streamCollectionWhereInWithWhere({
    required String path,
    required String field,
    required dynamic isEqualTo,
    required String whereInField,
    required List<Object?> whereIn,
    required String orderByField,
    bool descending = false,
  });

  // ---------- Search Future Data Collections ------------

  Future<List<DocumentSnapshot<Object?>>>? searchData({
    required String searchKey,
    required String path,
    required String orderBy,
    bool descending = false,
  });
}
