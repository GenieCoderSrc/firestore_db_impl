import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_db_impl/utils/exceptions/exception_handler/fire_store_exception_handler.dart';
import 'package:firestore_db_impl/utils/exceptions/fire_store_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:language_translator/language_translator.dart';
import 'package:app_toast/app_toast.dart';

import 'i_data_sources/i_firestor_bd_service.dart';

class FireStoreDbServiceImpl extends IFireStoreDbService {
// final FirebaseFirestore _db = firebaseService.getFireStoreInstance;

  FireStoreDbServiceImpl({FirebaseFirestore? fireStoreDb})
      : _fireStoreDb = fireStoreDb ?? FirebaseFirestore.instance;

  final FirebaseFirestore _fireStoreDb;
  late CollectionReference<Object?> _ref;

  // ---------- FireStore CRUD Operation ------------

  @override
  Future<dynamic> saveDocument({
    Map<String, dynamic>? data,
    required String path,
    String? successTxt,
  }) async {
    try {
      _ref = _fireStoreDb.collection(path);
      DocumentReference<Object?> value = await _ref.add(data);
      debugPrint("saveDocument id: ${value.id} Data: ${value.toString()}");
      if (successTxt != null) {
        AppToast.showToast(msg: successTxt);
      }

      return value;
    } catch (e) {
      debugPrint(
          "FireStoreDbServiceImpl | saveDocument | Failed to add data for: $e");
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);
      AppToast.showToast(
          msg:
              "${'failed_to_add_data_for'.translateWithoutContext()} ${exception.message.translateWithoutContext()}");
      return exception;
    }
  }

  @override
  Future<bool> addDocWithServerTime({
    required Map<String?, dynamic> data,
    required String path,
    required String timeField,
    String? successTxt,
  }) async {
    try {
      _ref = _fireStoreDb.collection(path);
      data[timeField] = FieldValue.serverTimestamp();

      await _ref.add(data as Map<String, Object?>);

      if (successTxt != null) {
        AppToast.showToast(msg: successTxt);
      }

      return true;
    } catch (e) {
      debugPrint('FireStoreDbServiceImpl | addDocWithServerTime | error: $e');
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);

      AppToast.showToast(msg: exception.message.translateWithoutContext());

      return false;
    }
  }

  @override
  Future<String?> setDocumentAutoId({
    required Map<String, dynamic> data,
    required String path,
    String? successTxt,
  }) async {
    try {
      _ref = _fireStoreDb.collection(path);

      final String id = _ref.doc().id;
      data['id'] = id;
      await _ref.doc(id).set(data);

      if (successTxt != null) {
        AppToast.showToast(msg: successTxt);
      }

      return id;
    } catch (e) {
      debugPrint('FireStoreDbServiceImpl | setDocumentAutoId | error: $e');
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);

      AppToast.showToast(msg: exception.message.translateWithoutContext());

      // Return null to indicate failure due to an exception
      return null;
    }
  }

  @override
  Future<bool> setDocument({
    Map<String, dynamic>? data,
    required String path,
    String? id,
    String? successTxt,
  }) async {
    try {
      _ref = _fireStoreDb.collection(path);

      await _ref.doc(id).set(data);

      AppToast.showToast(
          msg: successTxt ?? 'Successfully Added: ${data.toString()}');
      return true;
    } catch (e) {
      debugPrint('FireStoreDbServiceImpl | setDocument | Error: $e');
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);
      AppToast.showToast(msg: exception.message.translateWithoutContext());
      return false;
    }
  }

  @override
  Future<bool> updateDocument({
    required Map<String, dynamic> data,
    required String path,
    required String id,
    String? successTxt,
  }) async {
    try {
      debugPrint(
          'FirestoreDbServiceImpl | updateDocument | path: $path id: $id');
      _ref = _fireStoreDb.collection(path);
      await _ref.doc(id).update(data);

      debugPrint(
          "FireStoreDbServiceImpl | updateDocument | Data Updated Successfully.\nData: $data");
      if (successTxt != null && successTxt.isNotEmpty) {
        AppToast.showToast(msg: successTxt);
      }
      return true; // Return true to indicate success
    } catch (e) {
      debugPrint('FireStoreDbServiceImpl | updateDocument | error: $e');
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);

      AppToast.showToast(msg: exception.message.translateWithoutContext());
      return false; // Return false to indicate failure
    }
  }

  @override
  Future<bool> removeDocument({
    required String path,
    required String id,
    String? successTxt,
  }) async {
    try {
      _ref = _fireStoreDb.collection(path);
      await _ref.doc(id).delete();

      if (successTxt != null) {
        AppToast.showToast(msg: successTxt);
      }

      return true;
    } catch (e) {
      debugPrint('FireStoreDbServiceImpl | removeDocument | error: $e');
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);

      AppToast.showToast(msg: exception.message.translateWithoutContext());

      return false;
    }
  }

  // ---------- Get Single Future Data by ID ------------
  @override
  Future<DocumentSnapshot<Object?>?> getDocumentById(
      {required String path, required String id}) async {
    try {
      _ref = _fireStoreDb.collection(path);
      return await _ref.doc(id).get();
    } catch (e) {
      debugPrint('FireStoreDbServiceImpl | getDocumentById | error: $e');
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);

      AppToast.showToast(msg: exception.message.translateWithoutContext());

      return null;
    }
  }

  // ---------- Get Single Stream Data by ID ------------
  @override
  Stream<Object?>? streamDocumentById({required String path, String? id}) {
    try {
      _ref = _fireStoreDb.collection(path);
      return _ref
          .doc(id)
          .snapshots()
          .map((DocumentSnapshot<Object?> doc) => doc.data());
    } catch (e) {
      debugPrint('FireStoreDbServiceImpl | streamDocumentById | error: $e');
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);

      AppToast.showToast(msg: exception.message.translateWithoutContext());

      return null;
    }
  }

  // ---------- Future Data Collections ------------
  @override
  Query<Map<String, dynamic>> getCollectionRefWithWhere2(
          {required String path,
          required String field1,
          required isEqualTo1,
          required String field2,
          required isEqualTo2}) =>
      _fireStoreDb
          .collection(path)
          .where(field1, isEqualTo: isEqualTo1)
          .where(field2, isEqualTo: isEqualTo2);

  @override
  // Query<Object?>
  Query<Map<String, dynamic>> getCollectionRefWithWhere3({
    required String path,
    required String field1,
    dynamic isEqualTo1,
    required String field2,
    dynamic isEqualTo2,
    required String field3,
    dynamic isEqualTo3,
  }) =>
      _fireStoreDb
          .collection(path)
          .where(field1, isEqualTo: isEqualTo1)
          .where(field2, isEqualTo: isEqualTo2)
          .where(field3, isEqualTo: isEqualTo3);

  @override
  Future<QuerySnapshot<Map<String, dynamic>>?> getDataCollection({
    required String path,
    int? limit,
    String? orderByField,
    bool? isDescending,
  }) async {
    try {
      _ref = _fireStoreDb.collection(path);

      if (limit != null) {
        return await _ref
            .limit(limit)
            .orderBy(orderByField ?? '', descending: isDescending ?? false)
            .get() as QuerySnapshot<Map<String, dynamic>>?;
      }

      return await _ref.get() as QuerySnapshot<Map<String, dynamic>>?;
    } catch (e) {
      debugPrint('FireStoreDbServiceImpl | getDataCollection | error: $e');
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);
      AppToast.showToast(
          msg:
              "${'failed_to_get_data_collection'.translateWithoutContext()} ${exception.message.translateWithoutContext()}");
      return null;
    }
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>?> getDataCollectionWithWhere({
    required String path,
    required String field,
    String? isEqualTo,
  }) async {
    try {
      _ref = _fireStoreDb.collection(path);
      return await _ref
          .where(
            field,
            isEqualTo: isEqualTo,
          )
          .get() as QuerySnapshot<Map<String, dynamic>>?;
    } catch (e) {
      debugPrint(
          'FireStoreDbServiceImpl | getDataCollectionWithWhere | error: $e');
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);
      AppToast.showToast(
          msg:
              "${'failed_to_get_data_collection'.translateWithoutContext()} ${exception.message.translateWithoutContext()}");
      return null;
    }
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>?>
      getDataCollectionWithWhereLimitOrderBy({
    required String path,
    required String whereField,
    String? isEqualTo,
    required String orderByField,
    bool isDescending = false,
    int limit = 50,
  }) async {
    try {
      _ref = _fireStoreDb.collection(path);
      return await _ref
          .where(
            whereField,
            isEqualTo: isEqualTo,
          )
          .limit(limit)
          .orderBy(orderByField, descending: isDescending)
          .get() as QuerySnapshot<Map<String, dynamic>>?;
    } catch (e) {
      debugPrint(
          'FireStoreDbServiceImpl | getDataCollectionWithWhereLimitOrderBy | error: $e');
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);
      AppToast.showToast(
          msg:
              "${'failed_to_get_data_collection'.translateWithoutContext()} ${exception.message.translateWithoutContext()}");
      return null;
    }
  }

  // ---------- Get Stream Data Collections ------------
  @override
  Stream<List<Object?>>? streamDataCollection(String path) {
    try {
      _ref = _fireStoreDb.collection(path);
      return _ref.snapshots().map(_convertQuerySnapToListObj);
    } catch (e) {
      debugPrint('FireStoreDbServiceImpl | streamDataCollection | error: $e');
      return null;
    }
  }

  @override
  Stream<List<Object?>>? streamDataCollectionWithOrderBy({
    required String path,
    required String orderByField,
    bool descending = false,
  }) {
    try {
      _ref = _fireStoreDb.collection(path);
      return _ref
          .orderBy(orderByField, descending: descending)
          .snapshots()
          .map(_convertQuerySnapToListObj);
    } catch (e) {
      debugPrint(
          'FireStoreDbServiceImpl | streamDataCollectionWithOrderBy | error: $e');
      return null;
    }
  }

  @override
  Stream<List<Object?>>? streamDataCollectionWithWhere({
    required String path,
    required String field,
    dynamic isEqualTo,
  }) {
    try {
      _ref = _fireStoreDb.collection(path);
      return _ref
          .where(
            field,
            isEqualTo: isEqualTo,
          )
          .snapshots()
          .map(_convertQuerySnapToListObj); //as List<Map<String, dynamic>>
    } catch (e) {
      debugPrint('streamDataCollectionWithWhere |  error: $e');
      return null;
    }
  }

  @override
  Stream<List<Object?>>? streamDataCollectionWithWhere2(
      {required String path,
      required String field1,
      isEqualTo1,
      required String field2,
      isEqualTo2}) {
    try {
      _ref = _fireStoreDb.collection(path);
      return _ref
          .where(
            field1,
            isEqualTo: isEqualTo1,
          )
          .where(
            field2,
            isEqualTo: isEqualTo2,
          )
          .snapshots()
          .map(_convertQuerySnapToListObj); //as List<Map<String, dynamic>>
    } catch (e) {
      debugPrint(
          'FireStoreDbServiceImpl | streamDataCollectionWithWhere2 |  error: $e');
      return null;
    }
  }

  @override
  Stream<List<Object?>>? streamCollectionWhereArrayContains(
      {required String path,
      required String field,
      String? arrayContains,
      required String orderByField,
      bool descending = false}) {
    try {
      _ref = _fireStoreDb.collection(path);
      return _ref
          .where(field, arrayContains: arrayContains)
          .orderBy(orderByField, descending: descending)
          .snapshots()
          .map(_convertQuerySnapToListObj);
    } catch (e) {
      debugPrint(
          'FireStoreDbServiceImpl | streamCollectionWhereArrayContains |  error: $e');
      return null;
    }
  }

  @override
  Stream<List<Object?>>? streamDataCollectionWithOrderByAndLimit({
    required String path,
    required String orderByField,
    bool descending = false,
    required int limit,
  }) {
    try {
      _ref = _fireStoreDb.collection(path);
      return _ref
          .orderBy(orderByField, descending: descending)
          .limit(limit)
          .snapshots()
          .map(_convertQuerySnapToListObj);
    } catch (e) {
      debugPrint('FireStoreDbServiceImpl | getDocumentById | error: $e');
      return null;
    }
  }

  @override
  Stream<List<Object?>>? streamCollectionWhereIn(
      {required String path,
      required String field,
      List<Object?>? whereIn,
      required String orderByField,
      bool descending = false}) {
    try {
      _ref = _fireStoreDb.collection(path);
      return _ref
          .where(field, whereIn: whereIn)
          .orderBy(orderByField, descending: descending)
          .snapshots()
          .map(_convertQuerySnapToListObj);
    } catch (e) {
      debugPrint(
          'FireStoreDbServiceImpl | streamCollectionWhereIn |  error: $e');
      return null;
    }
  }

  @override
  Stream<List<Object?>>? streamCollectionWhereInWithWhere(
      {required String path,
      required String field,
      required isEqualTo,
      required String whereInField,
      required List<Object?> whereIn,
      required String orderByField,
      bool descending = false}) {
    try {
      _ref = _fireStoreDb.collection(path);
      return _ref
          .where(whereInField, whereIn: whereIn)
          .where(field, isEqualTo: isEqualTo)
          .orderBy(orderByField, descending: descending)
          .snapshots()
          .map(_convertQuerySnapToListObj);
    } catch (e) {
      debugPrint(
          'FireStoreDbServiceImpl | streamCollectionWhereInWithWhere |  error: $e');
      return null;
    }
  }

  // ---------- Search Future Data Collections ------------
  @override
  Future<List<DocumentSnapshot<Object?>>> searchData({
    required String searchKey,
    required String path,
    required String orderBy,
    bool descending = false,
  }) async {
    try {
      _ref = _fireStoreDb.collection(path);
      final snapshot = await _ref
          .orderBy(orderBy, descending: descending)
          .startAt([searchKey]).endAt(['$searchKey\uf8ff']).get();
      return snapshot.docs;
    } catch (e) {
      debugPrint('FireStoreDbServiceImpl | searchData | error: $e');
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);
      AppToast.showToast(msg: exception.message.translateWithoutContext());
      throw exception;
    }
  }

  // ----------  Data Collection Converter ------------
  List<Object?> _convertQuerySnapToListObj(QuerySnapshot<Object?> snapshot) =>
      snapshot.docs.map((DocumentSnapshot<Object?> doc) => doc.data()).toList();
}
