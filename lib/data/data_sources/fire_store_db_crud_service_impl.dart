import 'dart:async';

import 'package:app_toast/app_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_db_impl/data/modlels/query_parameter.dart';
import 'package:firestore_db_impl/extensions/qery_snapshot_extension.dart';
import 'package:firestore_db_impl/extensions/query_extension.dart';
import 'package:firestore_db_impl/firestore_db_impl.dart';
import 'package:firestore_db_impl/utils/exceptions/exception_handler/fire_store_exception_handler.dart';
import 'package:firestore_db_impl/utils/exceptions/fire_store_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:language_translator/language_translator.dart';

import 'i_data_sources/i_fire_store_db_crud_service.dart';

class FireStoreDbCrudServiceImpl extends IFireStoreDbCrudService {
  final FirebaseFirestore _fireStoreDb;

  FireStoreDbCrudServiceImpl({FirebaseFirestore? fireStoreDb})
    : _fireStoreDb = fireStoreDb ?? FirebaseFirestore.instance;

  late CollectionReference<Map<String, dynamic>> _collectionReference;

  @override
  Future<String?> saveDocument({
    required Map<String, dynamic> data,
    required String collectionPath,
    String? successTxt,
  }) async {
    try {
      _collectionReference = _fireStoreDb.collection(collectionPath);
      DocumentReference<Object?> value = await _collectionReference.add(data);
      debugPrint("saveDocument id: ${value.id} Data: ${value.toString()}");
      if (successTxt != null) {
        AppToast.showToast(msg: successTxt);
      }

      return value.id;
    } catch (e) {
      debugPrint(
        "FireStoreDbServiceImpl | saveDocument | Failed to add data for: $e",
      );
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);
      AppToast.showToast(
        msg:
            "${'failed_to_add_data_for'.translateWithoutContext()} ${exception.message.translateWithoutContext()}",
      );
      throw exception.message;
    }
  }

  @override
  Future<bool> setDocument({
    required Map<String, dynamic> data,
    required String collectionPath,
    required String id,
    bool merge = true,
    String? successTxt,
  }) async {
    try {
      _collectionReference = _fireStoreDb.collection(collectionPath);

      await _collectionReference.doc(id).set(data, SetOptions(merge: merge));

      debugPrint(
        'FireStoreDbCrudServiceImpl | setDocument |   Successfully Added: ${data.toString()}',
      );

      if (successTxt != null) {
        AppToast.showToast(msg: successTxt);
      }
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
    required String collectionPath,
    required String id,
    String? successTxt,
  }) async {
    try {
      _collectionReference = _fireStoreDb.collection(collectionPath);
      await _collectionReference.doc(id).update(data);
      debugPrint(
        "FireStoreDbServiceImpl | updateDocument | Data Updated Successfully.\nData: $data",
      );
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
    required String collectionPath,
    required String id,
    String? successTxt,
  }) async {
    try {
      _collectionReference = _fireStoreDb.collection(collectionPath);
      await _collectionReference.doc(id).delete();

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
  Future<Map<String, dynamic>?> getDocumentById({
    required String collectionPath,
    required String id,
  }) async {
    try {
      _collectionReference = _fireStoreDb.collection(collectionPath);
      DocumentSnapshot<Object?>? snapshot =
          await _collectionReference.doc(id).get();

      return snapshot.toMap();
    } catch (e) {
      debugPrint('FireStoreDbServiceImpl | getDocumentById | error: $e');
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);

      AppToast.showToast(msg: exception.message.translateWithoutContext());

      return null;
    }
  }

  // ---------- Get Future Data Collections ------------
  @override
  Future<List<Map<String, dynamic>?>?> getAllDocuments({
    required String collectionPath,
    List<QueryParameter>? queryParameters,
  }) async {
    try {
      _collectionReference = _fireStoreDb.collection(collectionPath);
      Query<Object?> query = _collectionReference.applyQueryParameters(
        queryParameters,
      );
      QuerySnapshot<Object?> querySnapshot = await query.get();

      debugPrint(
        'FireStoreDbServiceImpl | getAllDocumentsWithQuery | ID: ${querySnapshot.docs.first.id} data: ${querySnapshot.docs.first.data().toString()}',
      );

      return querySnapshot.toListOfMaps();
    } catch (e) {
      debugPrint(
        'FireStoreDbServiceImpl | getAllDocumentsWithQuery | error: $e',
      );
      final FireStoreException exception =
          FireStoreExceptionHandler.handleException(e);

      AppToast.showToast(msg: exception.message.translateWithoutContext());

      return null;
    }
  }

  // ---------- Get Stream Data Collections ------------
  @override
  Stream<List<Map<String, dynamic>?>?> getStreamAllDocuments({
    required String collectionPath,
    List<QueryParameter>? queryParameters,
  }) {
    _collectionReference = _fireStoreDb.collection(collectionPath);
    Query query = _collectionReference.applyQueryParameters(queryParameters);

    return query.snapshots().map(
      (querySnapshot) => querySnapshot.toListOfMaps(),
    );
  }
}
